#!/bin/bash
# A script which takes as input a directory name. 
# For each *jpg file, the script will generate a corresponding 
# -hipstah.jpg version using  ImageMagick's convert.

for pic in `find $1 -name '*.jpg'`
do
    echo $pic
    inputfile=$pic
    prefix=${inputfile%.jpg}
    outputfile=$prefix-hipstah.jpg
    convert -sepia-tone 60% +polaroid $inputfile $outputfile
done
