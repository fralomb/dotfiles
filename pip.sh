#!/bin/bash

venv=~/.local/pip
python3 -m venv "$venv"
source $venv/bin/activate

pip3 install python-lsp-server[all] python-lsp-isort python-lsp-black pylsp-rope python-lsp-ruff pyls-memestra rope

