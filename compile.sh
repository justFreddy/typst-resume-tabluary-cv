#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if [[ -f ".env" ]]; then
  source .env
fi

lang="${COMPILE_LANGUAGE:-de}"
mode_raw="${COMPILE_MODE:-cv}"
output=""

normalize_mode() {
  case "$1" in
    cv|resume|cv-only)
      echo "cv"
      ;;
    cl|cover-letter|letter)
      echo "cl"
      ;;
    separate|both-separate|both)
      echo "separate"
      ;;
    joint|combined|both-combined)
      echo "joint"
      ;;
    *)
      echo "$1"
      ;;
  esac
}

mode="$(normalize_mode "$mode_raw")"

usage() {
  cat <<'EOF'
Usage:
  ./compile.sh [output-path]
  ./compile.sh -v -l <lang> [-o <output-path>]
  ./compile.sh -c -l <lang> [-o <output-path>]
  ./compile.sh -s -l <lang>
  ./compile.sh -j -l <lang> [-o <output-path>]

Defaults:
  lang: de (from .env if present)
  mode: cv (from .env COMPILE_MODE if present, otherwise cv)
  output: out/cv-<firstname>_<lastname>-<lang>.pdf, out/cl-<firstname>_<lastname>-<lang>.pdf, or out/cv-cl-<firstname>_<lastname>-<lang>.pdf

Modes (can also be set via COMPILE_MODE in .env):
  -v or --cv              Compile only CV
  -c or --cover-letter    Compile only Cover Letter
  -s or --separate        Compile CV and Cover Letter as separate files
  -j or --joint           Compile CV and Cover Letter in one PDF
  (none)                  Compile only CV
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -l|--lang)
      lang="${2:-}"
      shift 2
      ;;
    -o|--output)
      output="${2:-}"
      shift 2
      ;;
    -c|--cover-letter)
      mode="cl"
      shift
      ;;
    -s|--separate)
      mode="separate"
      shift
      ;;
    -j|--joint)
      mode="joint"
      shift
      ;;
    -v|--cv)
      mode="cv"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      if [[ -z "$output" ]]; then
        output="$1"
        shift
      else
        echo "Unexpected argument: $1" >&2
        usage >&2
        exit 1
      fi
      ;;
  esac
done

case "$mode" in
  cv|cl|separate|joint)
    ;;
  *)
    echo "Unknown mode: $mode_raw" >&2
    usage >&2
    exit 1
    ;;
esac

if [[ -z "$lang" ]]; then
  echo "Language must not be empty." >&2
  exit 1
fi

if [[ ! -f "content/cv.${lang}.typ" ]]; then
  echo "Missing CV language file: content/cv.${lang}.typ" >&2
  exit 1
fi

if [[ ! -f "content/cl.${lang}.typ" ]]; then
  echo "Missing Cover Letter language file: content/cl.${lang}.typ" >&2
  exit 1
fi

if [[ ! -f "content/i18n/${lang}.typ" ]]; then
  echo "Missing i18n language file: content/i18n/${lang}.typ" >&2
  exit 1
fi

full_name="$(sed -nE 's/#let[[:space:]]+profile_name[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/p' "content/data.typ" | head -n1)"
if [[ -z "$full_name" ]]; then
  full_name="John Doe"
fi

first_name="$(awk '{print $1}' <<<"$full_name")"
last_name="$(awk '{print $NF}' <<<"$full_name")"

slugify() {
  tr '[:upper:]' '[:lower:]' <<<"$1" | sed -E 's/[^a-z0-9]+/_/g; s/^_+//; s/_+$//'
}

first_slug="$(slugify "$first_name")"
last_slug="$(slugify "$last_name")"

if [[ -z "$first_slug" ]]; then first_slug="first"; fi
if [[ -z "$last_slug" ]]; then last_slug="last"; fi

mkdir -p "out"

# Helper: compile a template with __LANG__ substituted from stdin to typst
compile_template_from_path() {
  local template_path="$1"
  local out_path="$2"
  awk -v lang="${lang}" '{gsub(/__LANG__/, lang)} 1' "$template_path" | typst compile - "$out_path"
}

case "$mode" in
  cv)
    if [[ -z "$output" ]]; then
      output="out/cv-${first_slug}_${last_slug}-${lang}.pdf"
    fi
    compile_template_from_path "cv.typ" "$output"
    echo "Compiled: $output"
    ;;
  cl)
    if [[ -z "$output" ]]; then
      output="out/cl-${first_slug}_${last_slug}-${lang}.pdf"
    fi
    compile_template_from_path "cl.typ" "$output"
    echo "Compiled: $output"
    ;;
  separate)
    if [[ -n "$output" ]]; then
      echo "Custom output is only supported for single-document or joint compilation modes." >&2
      exit 1
    fi

    cv_output="out/cv-${first_slug}_${last_slug}-${lang}.pdf"
    cl_output="out/cl-${first_slug}_${last_slug}-${lang}.pdf"

    compile_template_from_path "cv.typ" "$cv_output"
    compile_template_from_path "cl.typ" "$cl_output"
    echo "Compiled: $cv_output"
    echo "Compiled: $cl_output"
    ;;
  joint)
    if [[ -z "$output" ]]; then
      output="out/${first_slug}_${last_slug}-${lang}.pdf"
    fi

    sed "s/__LANG__/${lang}/g" "main.typ" | typst compile - "$output"
    echo "Compiled: $output"
    ;;
esac
