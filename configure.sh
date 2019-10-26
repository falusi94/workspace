#!/bin/bash

CONFIG_FILES=(
  '(./configs/config.fish ~/.config/fish/config.fish)'
)

for entry in "${CONFIG_FILES[@]}"
do
  eval paths=$entry
  echo Copying \"${paths[0]}\" to \"${paths[1]}\"
	cp ${paths[0]} ${paths[1]}
done
