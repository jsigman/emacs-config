#!/bin/bash
npm -g install pyright
npm -g install yaml-language-server

# html-ls and json-ls
npm -g install vscode-langservers-extracted

npm -g install dockerfile-language-server-nodejs
npm -g install bash-language-server
npm -g install prettier-plugin-toml
npm -g install remark-language-server

# Detect the operating system and install TexLab
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    echo "Installing TexLab using Homebrew..."
    brew install texlab
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    echo "Installing TexLab using Cargo..."
    cargo install texlab
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi
