#!/bin/bash

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

echo 'Install pynvim'
python3 -m pip3 install pynvim
