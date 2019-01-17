#!/bin/bash
# uses echo to print a rsync command with the correct paths for the current date
echo "rsync --archive --stats /cs/home/tkt_cam/public_html/`date +%Y/%m/%d`/ ~/ShellScripting2018/Week1/`date +%Y.%m.%d`"
