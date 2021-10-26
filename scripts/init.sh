#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

function errorf() {
  printf "ERROR: %s\n" "$@" > /dev/stderr
  exit 1
}

function init-sys() {
  apt-get update
  apt-get install -y \
    curl \
    git \
    make \
    npm \
    python3 \
    python3-pip \
    python3-venv \
    ruby-full \
    shellcheck \
  || errorf "Could not init system packages for rhad!"
}

function init-bats() {
  git clone https://github.com/bats-core/bats-core.git /tmp/bats
  /tmp/bats/install.sh /usr/local
}

function init-python() {
  pip3 install \
    mypy \
    pylint \
    pytest \
    pytest-cov \
  || errorf "Could not init Python packages for rhad!"
}

function init-ruby() {
  gem install \
    mdl \
  || errorf "Could not init Ruby packages for rhad!"
}

function main() {
  init-sys
  init-bats
  init-python
  init-ruby
}

main || errorf "Failed to initialize rhad host!"

exit 0