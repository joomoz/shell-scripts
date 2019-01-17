#!/bin/bash
# A script that prints the date and both the minium and maximum temperatures
# for each day 
# of the month (November 2011), separated by space, to a temporary file
# and then calls a gnuplot script to generate 
# an eps file "max-temps-2011-11.eps" showing the maximum temperatures 
# for each day of that month in a linespoints format.

day=""
max_temp=0
min_temp=999
temp_file=$(mktemp)

for file in `find ../Week3/lost24/monitor/2011.11.*/ -name hp-temps.txt | sort`
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
    set xrange ["2011.11.01":"2011.11.30"]
    set ylabel "Temp"
    set title "Temperatures"   
    set output "min-max-temps-2011-11.eps"
    plot "$temp_file" using 1:2 with linespoints linestyle 1 title 'max', \
      "$temp_file" using 1:3 with linespoints linestyle 3 title 'min'
EOF

rm $temp_file