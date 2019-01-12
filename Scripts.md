# Some random shell scripts

## RSYNC - copy or backup files from one NFS to another
```
rsync --archive --stats /cs/home/2018/11/11/ ~/ShellScripting2018/2018.11.11
```
## Redirect stdout to one file and stderr to another file simultaneously
```
ls /home/jmoilane/ShellScripting2018 > ~/ShellScripting2018/Week2/ls-home-successful.txt /foObarR 2> ~/ShellScripting2018/Week2/ls-unsuccessful.txt
```
## Count number of files
```
ls ~ | wc -l
```
## Redirect the output of ls to a file and then count the number of lines in the file
```
ls ~ >> files.txt; cat files.txt | wc -l
```
## Count only the number of folders in your home directory
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
