#!/usr/bin/env bash

set -euxo pipefail

# Detect architecture
ARCH=$(uname -m)
case ${ARCH} in
    x86_64)
        ARCH_SUFFIX="amd64"
        SSM_ARCH_SUFFIX="64bit"
        ;;
    aarch64)
        ARCH_SUFFIX="arm64"
        SSM_ARCH_SUFFIX="arm64"
        ;;
    *)
        echo "Unsupported architecture: ${ARCH}"
        exit 1
        ;;
esac

curl -sL "https://github.com/oras-project/oras/releases/download/v1.2.0/oras_1.2.0_linux_${ARCH_SUFFIX}.tar.gz" | sudo tar xvz -C /usr/local/bin/ oras

sudo curl -sL "https://github.com/mikefarah/yq/releases/download/v4.53.3/yq_linux_${ARCH_SUFFIX}" -o /usr/local/bin/yq && sudo chmod +x /usr/local/bin/yq

if ! command -v claude >/dev/null 2>&1; then
  curl -fsSL https://claude.ai/install.sh | bash
fi

# session-manager-plugin: needed by `aws ssm start-session` (e.g. port forwarding / exec into instances);
# not covered by the aws-cli devcontainer feature, so installed here
if ! command -v session-manager-plugin >/dev/null 2>&1; then
  SSM_DEB="$(mktemp -t session-manager-plugin-XXXXXX.deb)"
  curl -sL "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_${SSM_ARCH_SUFFIX}/session-manager-plugin.deb" -o "${SSM_DEB}"
  sudo dpkg -i "${SSM_DEB}"
  rm -f "${SSM_DEB}"
fi
