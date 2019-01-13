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



