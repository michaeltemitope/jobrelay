#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 || ! -r "$1" ]]; then
  printf '%s\n' 'Usage: bash scripts/check-commit-message.sh <message-file>' >&2
  exit 1
fi

subject=''
IFS= read -r subject < "$1" || true

# Keep this in sync with AGENTS.md Section 3.2; wording needs human review.
pattern='^(feat|fix|docs|refactor|perf|test|build|ci|chore|revert)\((api|relay|worker|contracts|db|infra|obs|ci|docs|deps|repo)\)!?: [^[:space:]].*$'
if [[ ! $subject =~ $pattern || ${#subject} -gt 72 || $subject == *. || $subject == *[[:space:]] ]]; then
  printf '%s\n' \
    'Invalid commit subject: use type(scope): imperative summary (max 72 characters).' \
    'Use an allowed type and scope from AGENTS.md; omit the trailing period.' >&2
  exit 1
fi
