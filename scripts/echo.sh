#!/bin/bash
# A script that echoes its command-line arguments back to it. For example,
# ./echo.sh I see a lot of files: `ls`
# returns
# I see a lot of files: bash-cat.sh echo.sh ssh-auto-try1.sh today.sh

for i in "$@"

do

  echo "$i"

done