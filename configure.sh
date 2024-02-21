#!/usr/bin/env bash

CONFIG_FILES=(
  '(./configs/fish/config.fish ~/.config/fish/config.fish)'
  '(./configs/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish)'
  '(./configs/vim/.vimrc ~/.vimrc)'
  '(./configs/vim/UltiSnips ~/.vim)'
)

echo 'Applying config'
echo '----------------------------------------'

for entry in "${CONFIG_FILES[@]}"
do
  eval paths=$entry
  echo Copying \"${paths[0]}\" to \"${paths[1]}\"
  cp -R ${paths[0]} ${paths[1]}
done
