#!/bin/bash

for f in *.tif; #loop function telling the script to run the loop for every .tif file, and sets the prefix before .tif to the variable  'f' inside the function
    do
        echo "Converting $f"; #prints to console that the file is being converted by referring to it by the file name without extension
        convert "$f" "$(basename "$f" .tif).png"; #uses convert "" "" function to convert one thing to another
        # convert is used to convert various aspects of an image
        # convert function is formatted as such: convert [input options] input file [output options] output file
        # to use convert to convert between image formats, use: convert input file output file, as no options are necessary
        # here, "$f" is 'input file'
        # and "$(basename "$f" .tif).png" is 'output file'.
        # basename is used here to isolate the file name for use in the output
        # basename is a function which returns the basename of a file without the suffix or directory
        # the format of the basename function is: basename string [SUFFIX]
        # that is used here as: basename "$f" .tif

    done
