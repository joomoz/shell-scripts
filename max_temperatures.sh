#!/bin/bash
# a bash script that finds the file (and temperature) 
# which contains the maximum processor temperature from November, 2011.

max_file=''
max_temp=0

for file in `find ./lost24/monitor/2011.11.*/ -name hp-temps.txt | sort`
do
  #echo "file: "$file
  current_temp="$(grep "PROCESSOR_ZONE\|#?" $file | cut -b 32-33)"
  #echo "Current temp:"  $current_temp
  if [ $current_temp -gt $max_temp ]; then
    echo "It's gettin hotter!"
    max_file=$file
    max_temp=$current_temp
  fi
done

echo "Maximum temperature:" $max_temp
echo "File:" $max_file
