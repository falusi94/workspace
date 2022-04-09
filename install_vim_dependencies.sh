#!/usr/bin/env bash

read -p "Are you sure? [y/N] " -n 1 -r

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  exit 0
fi

echo
echo 'Install fzf'
which fzf || brew install fzf

echo 'Install vim-plug'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo 'Install deno 🦖'
asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git
asdf install deno latest
