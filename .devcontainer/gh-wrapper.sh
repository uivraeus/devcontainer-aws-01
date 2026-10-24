#!/usr/bin/env bash
# Wrapper for the GitHub CLI, installed as /usr/local/bin/gh (shadows the real /usr/bin/gh).
#
# Supplies GH_TOKEN from git's credential helper (forwarded by VS Code to the host's GCM)
# on every call, just like git operations, so no token is ever stored in the container.

set -uo pipefail

REAL_GH=/usr/bin/gh

# Respect an explicitly provided token
if [[ -n "${GH_TOKEN:-}${GITHUB_TOKEN:-}${GH_ENTERPRISE_TOKEN:-}" ]]; then
  exec "$REAL_GH" "$@"
fi

# Commands that don't need a token: skip the credential lookup
# (avoids e.g. an account picker on `gh --version` or on tab completion)
case "${1:-}" in
  "" | --version | version | help | --help | -h | alias | completion | config | __complete)
    exec "$REAL_GH" "$@"
    ;;
esac

token=$(printf 'protocol=https\nhost=github.com\n\n' \
  | GIT_TERMINAL_PROMPT=0 git credential fill 2>/dev/null \
  | sed -n 's/^password=//p')
if [[ -z "$token" ]]; then
  echo "gh wrapper: got no GitHub credential from git's credential helper (is VS Code attached?)" >&2
  exec "$REAL_GH" "$@"
fi

GH_TOKEN="$token" exec "$REAL_GH" "$@"
