#!/bin/bash
# Now, you should've completed your min-max-temperature script. 
# It has a single argument format: a directory name. It will search 
# through the contents of the directory, and parse through a great 
# number of files to find either maximum and minimum temperatures.

# We will write a wrapper script that presents a user interface to 
# the, well, user. While tuning a graphical user interface can be 
# extremely time consuming, shell scripts are much easier. No paper 
# doll tryouts. No videotaping users.

# The trick will be to use getopts, which takes care of almost 
# all of the magic for you. But there is one thing that it will not 
# do. By now you have read a great number of man pages. You should've 
# noticed that some programs have very different ways of accepting 
# parameters. Due to historical reasons, there are (at least) three 
# different types. From man ps:

# This version of ps accepts several kinds of options:
# 1. UNIX options, which may be grouped and must be preceded by a dash.
# 2. BSD options, which may be grouped and must not be used with a dash.
# 3. GNU long options, which are preceded by two dashes.
# getopts is limited to UNIX-style arguments, but even that will 
# take us a long way. This tutorial will show you that way:

# http://wiki.bash-hackers.org/howto/getopts_tutorial
# Make a script using getopts and switch that can take a few options:

# -c: for coldest temperatures
# -w: for warmest temperatures
# -b for both temperatures
# -a to produce ASCII output instead of eps
# -h for help 
# and produce the desired figure


while getopts ":c:w:b:a:h" opt; do
  case $opt in
    c)
      echo "min temperatures, parameter: $OPTARG"
      bash min-max-temps-general.sh $OPTARG c
      ;;
    w)
      echo "max temperatures, parameter: $OPTARG"
      bash min-max-temps-general.sh $OPTARG w
      ;;
    b)
      echo "min and max temperatures, parameter: $OPTARG"
      bash min-max-temps-general.sh $OPTARG b
      ;;
    a)
      echo "produce ASCII output instead of eps, parameter: $OPTARG"
      bash min-max-temps-general.sh $OPTARG a
      ;;
    h)
      echo "Help: \n
        -c: for coldest temperatures \n
        -w: for warmest temperatures \n
        -b for both temperatures \n
        -a to produce ASCII output instead of eps \n
        -h for help" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument."
      exit 1
      ;;
  esac
done



$ cat min-max-temps-general.sh 
#!/bin/bash -f
day=""
max_temp=0
min_temp=999
temp_file=$(mktemp)
year="$(echo $1 | cut -b 25-28)"
month="$(echo $1 | cut -b 30-31)"
#../Week3/lost24/monitor/2011.11.*

echo $0, $1, $2

for file in `find $1*/ -name hp-temps.txt | sort`
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

if [ $2 == "c" ]; then
  gnuplot <<- EOF
    set terminal eps
    set xdata time
    set timefmt "%Y.%m.%d"
    set xlabel "Date"
    set xrange ["$year.$month.01":"$year.$month.31"]
    set ylabel "Temp"
    set title "Temperatures"   
    set output "min-temps-$year-$month.eps"
    plot "$temp_file" using 1:3 with linespoints linestyle 3 title 'min'
EOF
fi

if [ $2 == "w" ]; then
  gnuplot <<- EOF
    set terminal eps
    set xdata time
    set timefmt "%Y.%m.%d"
    set xlabel "Date"
    set xrange ["$year.$month.01":"$year.$month.31"]
    set ylabel "Temp"
    set title "Temperatures"   
    set output "max-temps-$year-$month.eps"
    plot "$temp_file" using 1:2 with linespoints linestyle 1 title 'max'
EOF
fi

if [ $2 == "b" ]; then
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
fi

if [ $2 == "a" ]; then
  gnuplot <<- EOF
    set terminal dumb
    set xdata time
    set timefmt "%Y.%m.%d"
    set xlabel "Date"
    set xrange ["$year.$month.01":"$year.$month.31"]
    set ylabel "Temp"
    set title "Temperatures"   
    plot "$temp_file" using 1:2 with linespoints linestyle 1 title 'max', \
      "$temp_file" using 1:3 with linespoints linestyle 3 title 'min'
EOF
fi

# gnuplot <<- EOF
#     set terminal eps
#     set xdata time
#     set timefmt "%Y.%m.%d"
#     set xlabel "Date"
#     set xrange ["$year.$month.01":"$year.$month.31"]
#     set ylabel "Temp"
#     set title "Temperatures"   
#     set output "min-max-temps-$year-$month.eps"
#     plot "$temp_file" using 1:2 with linespoints linestyle 1 title 'max', \
#       "$temp_file" using 1:3 with linespoints linestyle 3 title 'min'
# EOF

rm $temp_file