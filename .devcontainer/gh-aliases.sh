#!/usr/bin/env bash
# GitHub CLI aliases (stored in ~/.config/gh/config.yml, recreated on every container build)

set -euxo pipefail

gh alias set --clobber co 'pr checkout'
