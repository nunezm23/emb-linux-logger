#!/usr/bin/env bash

#
# Initialize the Yocto build environment for emb-linux-logger.
#
# This script must be sourced:
#
#   source scripts/setup-build.sh
#

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "ERROR: This script must be sourced."
    echo
    echo "Use:"
    echo "  source scripts/setup-build.sh"
    exit 1
fi

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

POKY_DIR="${PROJECT_ROOT}/layers/poky"
TEMPLATE_DIR="${PROJECT_ROOT}/layers/meta-emb-linux-logger/conf/templates/default"
BUILD_DIR="${PROJECT_ROOT}/build"

if [[ ! -f "${POKY_DIR}/oe-init-build-env" ]]; then
    echo "ERROR: Poky was not found at:"
    echo "  ${POKY_DIR}"
    echo
    echo "Initialize the Git submodules first:"
    echo "  git submodule update --init --recursive"
    return 1
fi

if [[ ! -f "${TEMPLATE_DIR}/local.conf.sample" ]] || \
   [[ ! -f "${TEMPLATE_DIR}/bblayers.conf.sample" ]]; then
    echo "ERROR: Yocto configuration templates were not found at:"
    echo "  ${TEMPLATE_DIR}"
    return 1
fi

export TEMPLATECONF="${TEMPLATE_DIR}"

echo "Project root : ${PROJECT_ROOT}"
echo "Poky         : ${POKY_DIR}"
echo "Template     : ${TEMPLATECONF}"
echo "Build dir    : ${BUILD_DIR}"
echo

source "${POKY_DIR}/oe-init-build-env" "${BUILD_DIR}"
