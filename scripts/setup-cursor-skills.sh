#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SOURCE_ROOT="${REPO_ROOT}/skills"
TARGET_ROOT="${HOME}/.cursor/skills"
MANIFEST_NAME=".curiosity-stack-managed"

DRY_RUN=0
CLEAN=0

usage() {
  cat <<'EOF'
Usage: ./scripts/setup-cursor-skills.sh [--clean] [--dry-run] [--help]

Syncs canonical skills from ./skills/*/SKILL.md to ~/.cursor/skills.

Options:
  --clean    Remove stale managed skill folders from ~/.cursor/skills
  --dry-run  Show changes without writing files
  --help     Show this message
EOF
}

for arg in "$@"; do
  case "${arg}" in
    --clean) CLEAN=1 ;;
    --dry-run) DRY_RUN=1 ;;
    --help|-h) usage; exit 0 ;;
    *)
      echo "Unknown option: ${arg}" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ ! -d "${SOURCE_ROOT}" ]]; then
  echo "Error: source directory not found: ${SOURCE_ROOT}" >&2
  exit 1
fi

SKILL_FILES=()
while IFS= read -r file; do
  SKILL_FILES+=("${file}")
done < <(LC_ALL=C find "${SOURCE_ROOT}" -mindepth 2 -maxdepth 2 -type f -name "SKILL.md" | sort)

if [[ ${#SKILL_FILES[@]} -eq 0 ]]; then
  echo "Error: no canonical skills found under ${SOURCE_ROOT}" >&2
  exit 1
fi

if [[ ${DRY_RUN} -eq 0 ]]; then
  mkdir -p "${TARGET_ROOT}"
else
  echo "[dry-run] would ensure target exists: ${TARGET_ROOT}"
fi

if [[ ! -d "${TARGET_ROOT}" && ${DRY_RUN} -eq 0 ]]; then
  echo "Error: target directory is not available: ${TARGET_ROOT}" >&2
  exit 1
fi

if [[ -d "${TARGET_ROOT}" && ! -w "${TARGET_ROOT}" && ${DRY_RUN} -eq 0 ]]; then
  echo "Error: target directory is not writable: ${TARGET_ROOT}" >&2
  exit 1
fi

installed=0
updated=0
unchanged=0
deleted=0

declare -a canonical_skills

for src in "${SKILL_FILES[@]}"; do
  skill_name="$(basename "$(dirname "${src}")")"
  canonical_skills+=("${skill_name}")
  dest_dir="${TARGET_ROOT}/${skill_name}"
  dest_file="${dest_dir}/SKILL.md"
  marker_file="${dest_dir}/${MANIFEST_NAME}"

  status="unchanged"
  if [[ ! -d "${dest_dir}" ]]; then
    status="installed"
  elif [[ ! -f "${dest_file}" ]]; then
    status="installed"
  elif ! cmp -s "${src}" "${dest_file}"; then
    status="updated"
  fi

  case "${status}" in
    installed) ((installed+=1)) ;;
    updated) ((updated+=1)) ;;
    unchanged) ((unchanged+=1)) ;;
  esac

  if [[ ${DRY_RUN} -eq 1 ]]; then
    echo "[dry-run] ${status}: ${skill_name}"
    continue
  fi

  mkdir -p "${dest_dir}"
  cp "${src}" "${dest_file}"
  cat > "${marker_file}" <<EOF
managed_by=curiosity-stack
source_repo=${REPO_ROOT}
source_file=${src}
EOF
  echo "${status}: ${skill_name}"
done

if [[ ${CLEAN} -eq 1 ]]; then
  managed_dirs=()
  if [[ -d "${TARGET_ROOT}" ]]; then
    while IFS= read -r dir; do
      managed_dirs+=("${dir}")
    done < <(LC_ALL=C find "${TARGET_ROOT}" -mindepth 1 -maxdepth 1 -type d | sort)
  fi
  for dir in "${managed_dirs[@]}"; do
    marker="${dir}/${MANIFEST_NAME}"
    [[ -f "${marker}" ]] || continue
    skill="$(basename "${dir}")"
    keep=0
    for canonical in "${canonical_skills[@]}"; do
      if [[ "${canonical}" == "${skill}" ]]; then
        keep=1
        break
      fi
    done
    [[ ${keep} -eq 1 ]] && continue

    if [[ ${DRY_RUN} -eq 1 ]]; then
      echo "[dry-run] delete stale managed skill: ${skill}"
    else
      rm -rf "${dir}"
      ((deleted+=1))
      echo "deleted stale managed skill: ${skill}"
    fi
  done
fi

echo
echo "Sync summary:"
echo "  canonical skills: ${#SKILL_FILES[@]}"
echo "  installed: ${installed}"
echo "  updated: ${updated}"
echo "  unchanged: ${unchanged}"
if [[ ${CLEAN} -eq 1 ]]; then
  echo "  deleted stale: ${deleted}"
fi
echo "  target: ${TARGET_ROOT}"

