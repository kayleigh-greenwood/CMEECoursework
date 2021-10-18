#!/bin/bash
# Author: Kayleigh Greenwood kg21@imperial.ac.uk
# Script: CountLines.sh
# Description: counts the number of newlines in a file.
#
# Prints the output into the terminal
# Arguments: 1 -> printed newline count
# Date: Oct 15th 2021

if [[ -f $1 ]] # if the user has entered a file
then
    NumLines=`wc -l < $1` #counts the number of newlines in the file the user has inputted and assigning this value to NumLines

    Filename=$(basename $1) # removes path

    echo -e "\nNewlines in '$Filename': $NumLines.\n" #Prints line count of the variable to the console
elif [ -z $1 ] # if there hasn't entered anything
then
    echo 'Error: Please input a file to produce the newline count.'
else # if the user has entered something but it isn't an existing file
    echo 'Error: Wrong input format. Please input existing files only.'
fi

exit