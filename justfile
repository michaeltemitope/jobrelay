# List available foundation checks.
default:
    @just --list

# Check tracked, unstaged whitespace changes.
check-whitespace:
    git diff --check

# Check the commit validator's Bash syntax.
check-shell:
    bash -n scripts/check-commit-message.sh

# Service lint, types, and tests are introduced in Phase 1 Part C.
check: check-whitespace check-shell
