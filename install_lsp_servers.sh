#!/bin/bash
npm -g install pyright
npm -g install yaml-language-server

# html-ls and json-ls
npm -g install vscode-langservers-extracted

npm -g install dockerfile-language-server-nodejs
npm -g install bash-language-server
npm -g install prettier-plugin-toml

EXECUTABLE=~/.local/bin/marksman
curl https://github.com/artempyanykh/marksman/releases/download/2022-10-30/marksman-macos -o $EXECUTABLE
chmod +x $EXECUTABLE
xattr -d com.apple.quarantine $EXECUTABLE
