#!/bin/bash

# A script that takes one numerical argument n, and produces 
# n lines with two random numbers. For example, create-random-data.sh 5 
# could produce:

# 7440 6271
# 16564 10906
# 31425 13410
# 13382 27114
# 11510 28041

# A gnuplot script that will print that data points (x,y) from random-data.txt
# using the first random number as x and the second as y.
#
# plot-data.gnuplot: (file)
# set terminal dumb
# plot "random-data.txt"

#$ gnuplot plot-data.gnuplot 

if ! [[ "$1" =~ ^[0-9]+$ ]] ; then
   echo "Error: Give an integer!" >&2; exit 1
fi

counter=1
while [ $counter -le $1 ]
do
  echo $(( $RANDOM % 99999 )) $(( $RANDOM % 99999 ))
  ((counter++))
done

