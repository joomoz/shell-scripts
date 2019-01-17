#!/bin/bash
#  A script that takes as parameter a folder representing a month 
#  (example: ...../lost24/monitor/2011.10* for October 2011) 
#  and generate the according plot "min-max-temps-2011-10.eps

day=""
max_temp=0
min_temp=999
temp_file=$(mktemp)
year="$(echo $1 | cut -b 25-28)"
month="$(echo $1 | cut -b 30-31)"
#../Week3/lost24/monitor/2011.11.*

for file in `find $1/ -name hp-temps.txt | sort`
do
  current_temp="$(grep "PROCESSOR_ZONE\|#?" $file | cut -b 32-33)"
  current_day="$(echo $file | cut -b 25-34)"
#   echo "Current temp:"  $current_temp
#   echo "Current day:"  $current_day
  if [[ $current_day != $day && $day != "" ]]; then
    # Write previous day into a file!
    echo "$day $max_temp $min_temp" >> $temp_file
    # echo "$day $max_temp"
    max_temp=0
    min_temp=999
  fi

  if [ $current_temp -gt $max_temp ]; then
    max_temp=$current_temp
  fi

  if [ $current_temp -lt $min_temp ]; then
    min_temp=$current_temp
  fi

  day=$current_day
done

#Write last day into a file
echo "$day $max_temp $min_temp" >> $temp_file

gnuplot <<- EOF
    set terminal eps
    set xdata time
    set timefmt "%Y.%m.%d"
    set xlabel "Date"
    set xrange ["$year.$month.01":"$year.$month.31"]
    set ylabel "Temp"
    set title "Temperatures"   
    set output "min-max-temps-$year-$month.eps"
    plot "$temp_file" using 1:2 with linespoints linestyle 1 title 'max', \
      "$temp_file" using 1:3 with linespoints linestyle 3 title 'min'
EOF

rm $temp_file