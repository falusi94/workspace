#!/usr/bin/env bash

CONFIG_FILES=(
  '(./configs/fish/config.fish ~/.config/fish/config.fish)'
  '(./configs/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish)'
  '(./configs/atom/snippets.cson ~/.atom/snippets.cson)'
  '(./configs/vim/.vimrc ~/.vimrc)'
)

echo 'Applying config'
echo '----------------------------------------'

for entry in "${CONFIG_FILES[@]}"
do
  eval paths=$entry
  echo Copying \"${paths[0]}\" to \"${paths[1]}\"
	cp ${paths[0]} ${paths[1]}
done
