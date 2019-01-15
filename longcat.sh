#!/bin/bash
# A script called longcat.sh which accepts a single, numerical (greater than 0)
# command line parameter. a numerical parameter larger than 1 will extend 
# the stomach of the cat to match the number of requested lines.
# Passing anything else than a numerical parameter will print a helpful
# message and exit with a status of 1

if ! [[ "$1" =~ ^[0-9]+$ ]] ; then
   echo "Error: Give an integer!" >&2; exit 1
fi

echo '   '/\\___/\\
echo '  '/'       '\\
echo " |  #   # |"
echo ' '\\"     @  |"
echo '  '\\"   _|_ /"
echo '  '/'       '\\______
echo ' '/' '_______ ___'   '\\
echo ' '"|_____   "\\'   '\\__/
echo "  |    "\\__/

counter=1
while [ $counter -le $1 ]
do
  echo "  |       |"
  ((counter++))
done

echo '  '/'        '\\
echo ' '/'   '____'   '\\
echo " |  "/'    '\\"  |"
echo " | |      | |"
echo '/'"  |      |  "\\
echo \\__/'      '\\__/