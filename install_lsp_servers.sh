#!/bin/bash
npm -g install pyright
npm -g install yaml-language-server

# html-ls and json-ls
npm -g install vscode-langservers-extracted

npm -g install dockerfile-language-server-nodejs
npm -g install bash-language-server
npm -g install prettier-plugin-toml
npm -g install remark-language-server

npm -g install copilot-node-server
ln -s /opt/homebrew/lib/node_modules/copilot-node-server/bin/copilot-node-server /opt/homebrew/bin/copilot-node-server
