#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

MARKETPLACE_NAME="curiosity-stack"
PLUGIN_NAME="curiosity-stack"
PLUGIN_REF="${PLUGIN_NAME}@${MARKETPLACE_NAME}"

DRY_RUN=0
MODE="install"

usage() {
  cat <<'EOF'
Usage: ./scripts/setup-claude-plugin.sh [--update] [--uninstall] [--dry-run] [--help]

Registers this repo as a local Claude Code marketplace and installs the
curiosity-stack plugin (skills, agents, commands, hooks).

Options:
  --update     Refresh the marketplace and reinstall to pick up local edits
  --uninstall  Uninstall the plugin and remove the marketplace entry
  --dry-run    Print actions without executing
  --help       Show this message
EOF
}

for arg in "$@"; do
  case "${arg}" in
    --dry-run) DRY_RUN=1 ;;
    --update) MODE="update" ;;
    --uninstall) MODE="uninstall" ;;
    --help|-h) usage; exit 0 ;;
    *)
      echo "Unknown option: ${arg}" >&2
      usage
      exit 1
      ;;
  esac
done

log() { echo "$@"; }
err() { echo "$@" >&2; }

run_cmd() {
  if [[ ${DRY_RUN} -eq 1 ]]; then
    echo "[dry-run] $*"
    return 0
  fi
  "$@"
}

run_cmd_capture() {
  if [[ ${DRY_RUN} -eq 1 ]]; then
    echo "[dry-run] $*" >&2
    echo ""
    return 0
  fi
  "$@"
}

require_file() {
  local path="$1"
  if [[ ! -f "${path}" ]]; then
    err "Error: required file missing: ${path}"
    exit 1
  fi
}

require_dir() {
  local dir="$1"
  if [[ ! -d "${dir}" ]]; then
    err "Error: required directory missing: ${dir}"
    exit 1
  fi
}

require_min_count() {
  local count="$1"
  local label="$2"
  local where="$3"
  if [[ "${count}" -eq 0 ]]; then
    err "Error: no ${label} found under ${where}"
    exit 1
  fi
}

validate_json() {
  local path="$1"
  if ! python3 -c "import json,sys; json.load(open(sys.argv[1]))" "${path}" 2>/dev/null; then
    err "Error: invalid JSON: ${path}"
    exit 1
  fi
}

HOOKS_SHAPE_SCRIPT='
import json, sys
try:
    data = json.load(open(sys.argv[1]))
except Exception as e:
    sys.stderr.write(f"parse error: {e}\n")
    sys.exit(2)
hooks = data.get("hooks") if isinstance(data, dict) else None
if not isinstance(hooks, dict) or not hooks:
    sys.stderr.write("missing top-level \"hooks\" object with at least one event\n")
    sys.exit(2)
for event, entries in hooks.items():
    if not isinstance(entries, list) or not entries:
        sys.stderr.write(f"event {event!r}: must be a non-empty array\n")
        sys.exit(2)
    for i, entry in enumerate(entries):
        if not isinstance(entry, dict):
            sys.stderr.write(f"{event}[{i}]: must be an object\n")
            sys.exit(2)
        inner = entry.get("hooks")
        if not isinstance(inner, list) or not inner:
            sys.stderr.write(f"{event}[{i}].hooks: must be a non-empty array (matcher-group shape)\n")
            sys.exit(2)
        for j, h in enumerate(inner):
            if not isinstance(h, dict) or "type" not in h:
                sys.stderr.write(f"{event}[{i}].hooks[{j}]: must be an object with a \"type\" field\n")
                sys.exit(2)
sys.exit(0)
'

validate_hooks_shape() {
  local path="$1"
  local err_out
  if ! err_out="$(python3 -c "${HOOKS_SHAPE_SCRIPT}" "${path}" 2>&1)"; then
    err "Error: ${path} does not match Claude Code's hooks schema"
    err "       each event entry must be a matcher group with a \"hooks\": [] array"
    [[ -n "${err_out}" ]] && err "       detail: ${err_out}"
    exit 1
  fi
}

count_skills() {
  LC_ALL=C find "${REPO_ROOT}/skills" -mindepth 2 -maxdepth 2 -type f -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' '
}

count_agents() {
  LC_ALL=C find "${REPO_ROOT}/agents" -mindepth 1 -maxdepth 1 -type f -name "*.md" 2>/dev/null | wc -l | tr -d ' '
}

count_commands() {
  LC_ALL=C find "${REPO_ROOT}/commands" -mindepth 1 -maxdepth 1 -type f -name "*.md" 2>/dev/null | wc -l | tr -d ' '
}

count_hook_events() {
  python3 - "${REPO_ROOT}/hooks/hooks.json" <<'PY' 2>/dev/null || echo 0
import json, sys
try:
    data = json.load(open(sys.argv[1]))
    hooks = data.get("hooks", {}) or {}
    total = 0
    for _, entries in hooks.items():
        if isinstance(entries, list):
            total += len(entries)
    print(total)
except Exception:
    print(0)
PY
}

plugin_version() {
  python3 - "${REPO_ROOT}/.claude-plugin/plugin.json" <<'PY' 2>/dev/null || echo "unknown"
import json, sys
try:
    print(json.load(open(sys.argv[1])).get("version", "unknown"))
except Exception:
    print("unknown")
PY
}

JSON_HAS_MATCH_SCRIPT='
import json, sys
target = sys.argv[1]
field = sys.argv[2]
key = sys.argv[3]
try:
    data = json.load(sys.stdin)
except Exception:
    sys.exit(1)
items = data if isinstance(data, list) else (data.get(key) if isinstance(data, dict) else None)
for it in items or []:
    if not isinstance(it, dict):
        continue
    val = it.get(field)
    if val == target:
        sys.exit(0)
    if field == "id" and isinstance(val, str) and val.split("@", 1)[0] == target:
        sys.exit(0)
sys.exit(1)
'

marketplace_registered() {
  local out
  if ! out="$(claude plugin marketplace list --json 2>/dev/null)"; then
    return 1
  fi
  python3 -c "${JSON_HAS_MATCH_SCRIPT}" "${MARKETPLACE_NAME}" "name" "marketplaces" <<<"${out}"
}

plugin_installed() {
  local out
  if ! out="$(claude plugin list --json 2>/dev/null)"; then
    return 1
  fi
  python3 -c "${JSON_HAS_MATCH_SCRIPT}" "${PLUGIN_NAME}" "id" "plugins" <<<"${out}"
}

preflight() {
  log "Preflight: checking artifacts under ${REPO_ROOT}"

  require_file "${REPO_ROOT}/.claude-plugin/plugin.json"
  require_file "${REPO_ROOT}/.claude-plugin/marketplace.json"
  require_file "${REPO_ROOT}/hooks/hooks.json"

  validate_json "${REPO_ROOT}/.claude-plugin/plugin.json"
  validate_json "${REPO_ROOT}/.claude-plugin/marketplace.json"
  validate_json "${REPO_ROOT}/hooks/hooks.json"
  validate_hooks_shape "${REPO_ROOT}/hooks/hooks.json"

  require_dir "${REPO_ROOT}/skills"
  require_dir "${REPO_ROOT}/agents"
  require_dir "${REPO_ROOT}/commands"

  require_min_count "$(count_skills)" "SKILL.md files" "${REPO_ROOT}/skills"
  require_min_count "$(count_agents)" "agent .md files" "${REPO_ROOT}/agents"
  require_min_count "$(count_commands)" "command .md files" "${REPO_ROOT}/commands"

  if ! command -v claude >/dev/null 2>&1; then
    err "Error: 'claude' CLI not found on PATH."
    err "Install Claude Code first: https://docs.claude.com/en/docs/claude-code"
    exit 1
  fi

  if ! claude plugin --help >/dev/null 2>&1; then
    err "Error: this Claude Code build does not expose 'claude plugin' subcommands."
    err "Open Claude Code and run these slash commands instead:"
    err "  /plugin marketplace add ${REPO_ROOT}"
    err "  /plugin install ${PLUGIN_REF}"
    exit 2
  fi

  if ! python3 -c "import json" >/dev/null 2>&1; then
    err "Error: python3 is required for JSON validation/parsing."
    exit 1
  fi
}

do_install() {
  local status_label="installed"

  if marketplace_registered; then
    log "marketplace: already registered (${MARKETPLACE_NAME})"
    status_label="unchanged"
  else
    log "marketplace: adding ${MARKETPLACE_NAME} from ${REPO_ROOT}"
    run_cmd claude plugin marketplace add "${REPO_ROOT}"
    status_label="installed"
  fi

  if plugin_installed; then
    log "plugin: already installed (${PLUGIN_NAME})"
  else
    log "plugin: installing ${PLUGIN_REF}"
    run_cmd claude plugin install "${PLUGIN_REF}"
    status_label="installed"
  fi

  if [[ ${DRY_RUN} -eq 0 ]] && ! plugin_installed; then
    err "Error: verification failed - ${PLUGIN_NAME} not visible in 'claude plugin list'"
    exit 1
  fi

  print_summary "${status_label}"
}

do_update() {
  if ! marketplace_registered; then
    log "marketplace: not registered yet, adding ${MARKETPLACE_NAME}"
    run_cmd claude plugin marketplace add "${REPO_ROOT}"
  else
    log "marketplace: refreshing ${MARKETPLACE_NAME}"
    if ! run_cmd claude plugin marketplace update "${MARKETPLACE_NAME}"; then
      log "marketplace update failed; falling back to remove + add"
      run_cmd claude plugin marketplace remove "${MARKETPLACE_NAME}" || true
      run_cmd claude plugin marketplace add "${REPO_ROOT}"
    fi
  fi

  if plugin_installed; then
    log "plugin: updating ${PLUGIN_NAME}"
    if ! run_cmd claude plugin update "${PLUGIN_NAME}"; then
      log "plugin update failed; falling back to reinstall"
      run_cmd claude plugin uninstall "${PLUGIN_NAME}" || true
      run_cmd claude plugin install "${PLUGIN_REF}"
    fi
  else
    log "plugin: not installed yet, installing ${PLUGIN_REF}"
    run_cmd claude plugin install "${PLUGIN_REF}"
  fi

  if [[ ${DRY_RUN} -eq 0 ]] && ! plugin_installed; then
    err "Error: verification failed after update - ${PLUGIN_NAME} not visible"
    exit 1
  fi

  print_summary "updated"
}

do_uninstall() {
  if plugin_installed; then
    log "plugin: uninstalling ${PLUGIN_NAME}"
    run_cmd claude plugin uninstall "${PLUGIN_NAME}" || true
  else
    log "plugin: not installed (skipped)"
  fi

  if marketplace_registered; then
    log "marketplace: removing ${MARKETPLACE_NAME}"
    run_cmd claude plugin marketplace remove "${MARKETPLACE_NAME}" || true
  else
    log "marketplace: not registered (skipped)"
  fi

  print_summary "uninstalled"
}

print_summary() {
  local status="$1"
  local skills agents commands hook_events version
  skills="$(count_skills)"
  agents="$(count_agents)"
  commands="$(count_commands)"
  hook_events="$(count_hook_events)"
  version="$(plugin_version)"

  echo
  echo "Sync summary:"
  echo "  marketplace: ${MARKETPLACE_NAME} (${REPO_ROOT})"
  echo "  plugin: ${PLUGIN_NAME}@${version}"
  echo "  skills: ${skills}"
  echo "  agents: ${agents}"
  echo "  commands: ${commands}"
  echo "  hook events: ${hook_events}"
  echo "  status: ${status}"
  if [[ ${DRY_RUN} -eq 1 ]]; then
    echo "  mode: dry-run (no changes made)"
  fi
}

preflight

case "${MODE}" in
  install) do_install ;;
  update) do_update ;;
  uninstall) do_uninstall ;;
esac
