#!/usr/bin/env bash

set -euxo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
printf "\n\n\n### APPENDED by postCreateCommand ###\n\n" >> ~/.bashrc
cat ${SCRIPT_DIR}/bashrc_append >> ~/.bashrc

# Named volumes (e.g. .claude, .aws) are created owned by root, so fix ownership
# of the whole home dir to make them writable by the current user
sudo chown -R "$(id -u):$(id -g)" "$HOME"

$SCRIPT_DIR/download-tools.sh

# gh wrapper supplying GH_TOKEN from the host's git credentials (see gh-wrapper.sh)
sudo install -m 755 "${SCRIPT_DIR}/gh-wrapper.sh" /usr/local/bin/gh
$SCRIPT_DIR/gh-aliases.sh

sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y \
  bat \
  jq \
  ripgrep



