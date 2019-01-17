# Shell commands and scripts
Shell commands and scripts from university course

### RSYNC - copy or backup files from one NFS to another
```
rsync --archive --stats /cs/home/2018/11/11/ ~/ShellScripting2018/2018.11.11
```
### Redirect stdout to one file and stderr to another file simultaneously
```
ls /home/jmoilane/ShellScripting2018 > ~/ShellScripting2018/Week2/ls-home-successful.txt /foObarR 2> ~/ShellScripting2018/Week2/ls-unsuccessful.txt
```
### Count number of files
```
ls ~ | wc -l
```
### Redirect the output of ls to a file and then count the number of lines in the file
```
ls ~ >> files.txt; cat files.txt | wc -l
```
### Count only the number of folders in your home directory
```
ls -d ~/*/ >> folders.txt; cat folders.txt | wc -l
```
## grep - global regular expression (and) print
### case-sensitive match
```
ls ~ | grep 'searched_text'
```
### count files that match the search (.txt-files)
```
ls ~ | grep '*.txt' | wc -l
```

## Bash scripts
### Files begin with the line '#!/bin/bash'. Give execution permission 'sudo chmod u+x 'filename.sh'.
### Previous file count in a bash script
```
#!/bin/bash
ls ~ | wc -l
```
### List all files and subdirectorie
```
#!/bin/bash
ls -R /cs/home/tkt_cam/public_html/2011/11
```
### List only pics
```
#!/bin/bash
ls -R /cs/home/tkt_cam/public_html/2011/11 | grep '.jpg'
```
### Then count the number of pics
```
#!/bin/bash
ls -R /cs/home/tkt_cam/public_html/2011/11 | grep '.jpg' | wc -l
```
### Count pics for current month
```
#!/bin/bash
ls -R /cs/home/tkt_cam/public_html/$(date +%Y/%m)/ | grep '.jpg' | wc -l 
```

## Find
A script that finds the image files corresponding to the current month and counts them. Using find, date, and wc -l.
```
#!/bin/bash
find /cs/home/tkt_cam/public_html/$(date +%Y/%m)/ -type f | wc -l
```

## Tar - compress (catenate)
tar cjf destination-archive.tar.bz2 source-files [optional-more-files] creates a tarball and compresses it with bzip2
tar czf destination-archive.tar.gz source-files [optional-more-files] creates a tarball and compresses it with gzip
Compress your collection of shell scripts (and pictures downloaded last weeks, to get some mass for the files) using (tar with gzip) and (tar with bzip2). Show a comparison of the file sizes from both methods with the compressed tarball.
Figure out how to bypass tar's shortcut and call bzip2 and gzip explicitly by using a pipeline.
```
tar cjf destination-archive.tar.bz2 `find ~/ -name *.sh -o -name *.jpg`
tar czf destination-archive.tar.gz `find ~/ -name *.sh -o -name *.jpg`

tar cf - `find ~/ -name *.sh -o -name *.jpg` | bzip2 > bzipped.bz2
tar cf - `find ~/ -name *.sh -o -name *.jpg` | gzip > gzipped.gz
```
### Fetch and extract
Extractions is very similar, but instead of c for catenate we use x for extract. Before we can do this, we need a compressed tarball to begin with.
Uncompress and extract the file in a pipeline, i.e., without first saving the compressed tarball to disk on local file system.
```
wget -qO-  'https://wiki.helsinki.fi/download/attachments/124126879/lost24-monitor-temps-and-fans-v2.tar.bz2?version=1&modificationDate=1383226184357&api=v2' | tar xvj
```

## Grep and cut
Use grep to select individual lines and cut to separate the line contents into usable variables.
Report which unique PROCESSOR_ZONE temperatures (unique temperature) were recorded on 2011.12.25. Your output must return the temperatures in degrees Celsius only.
```
~/ShellScripting2018/Week3$ grep -r -u "PROCESSOR_ZONE\|#?" lost24/monitor/2011.12.25/*/hp-temps.txt | cut -b 77-78 | sort -u
22
```
Cut in this form is fragile, though. Even minute changes in the input format will break cut if the user has specified selections using character counts.
One way to work around this problem is to rewrite the source text in an intermediary phase and then do selection. Next, we will introduce you to sed, which is powerful like a roundhouse kick, but painful to get just right. Sed uses regular expressions extensively.
Grep PROCESSOR_ZONE like you did in the last exercise and write a sed expression that rewrites consecutive spaces as commas and also rewrites all slashes as commas so your output looks like a CVS file.
```
grep -r -u "PROCESSOR_ZONE" lost24/monitor/2011.12.25/*/hp-temps.txt| sed -e 's| \+|,|g' -e 's|/|,|g'
```
### When ls chokes, use find! But remember to use single quotes!
```
find ./2011.11.*/ -name '*temps.txt' | sort
```

## Testing equality
Be very thorough with the placement of spaces around the square brackets, since the shell interpreter might get confused otherwise
```
prev_value=15
curr_value=25
if [ $prev_value -lt $curr_value ]; then
  echo "Is it me, or is it getting hotter?"
else
   echo "Somebody turn up the heat, I'm freezing..."
fi
```

## Commandline calculator (bc)
It can perform very difficult mathematical operations, at the price of its own quirks regarding syntax. For example, the scale variable is used to truncate result precision, but it doesn't do rounding
```
$ echo "scale=2; 55575.23923 / 3" | bc
18525.07
  
$ echo "scale=3; 55575.23923 / 3" | bc
18525.079
```
## bc example - average.sh 
Calculates the arithmetic mean of the input parameters ($1, $2, ...) using bc.
```
#!/bin/bash

sum=0
for var in "$@"
do
  let "sum += $var"
done

echo "scale=2; $sum / $#" | bc
```
