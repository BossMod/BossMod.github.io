#!/bin/bash

i_or_ci(){
if [[ -f package-lock.json ]]; then
npm ci
else
npm i
fi
}

echo "::group::Cloning repositories"
git clone https://github.com/BossMod/scratch-gui --depth=1
git clone https://github.com/BossMod/scratch-vm --depth=1
git clone https://github.com/BossMod/scratch-blocks --depth=1
echo "::endgroup::"
echo "::group::Build scratch-blocks"
cd scratch-blocks
git branch developBuilds
i_or_ci
cd ..
echo "::endgroup::"
echo "::group::Build scratch-vm"
cd scratch-vm
i_or_ci
cd ..
echo "::endgroup::"
echo "::group::Build scratch-gui"
cd scratch-gui
i_or_ci
npm link ../scratch-vm
npm link ../scratch-blocks
npm run build
echo "::endgroup::"
