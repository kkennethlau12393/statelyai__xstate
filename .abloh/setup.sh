#!/usr/bin/env bash
# Written by abloh init. This file is how your project builds.
# It is the single source of truth for the steps abloh runs before it measures your suite,
# and abloh never guesses around it.
# Edit it freely. Plain shell, one step per block. Your coding agent can edit it too.
set -euo pipefail

# step 1: OS packages your suite needs, pinned. From your suite said "#10 41.73 .../.pnpm/husky@3.1.0/node_modules/husky install: spawnSync git ENOENT"
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends git=1:2.39.5-0+deb12u3
rm -rf /var/lib/apt/lists/*

# step 2: put the package manager on PATH, for your own lifecycle scripts. From pnpm-lock.yaml, pnpm@9.15.9
corepack enable

# step 3: dependencies, from your lockfile. From pnpm-lock.yaml, pnpm@9.15.9
corepack pnpm install --frozen-lockfile

# step 4: your build. From nodejs.yml::build
pnpm build

# step 5: your build. From nodejs.yml::build
pnpm typecheck

# After this script finishes, your suite runs sealed: no network, no secrets.
