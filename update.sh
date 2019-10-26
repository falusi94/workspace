#!/bin/sh

echo 'Pulling changes from remote'
echo '----------------------------------------'
git pull --rebase

echo '\n'
./configure.sh
