#!/bin/bash
# Author: Kayleigh Greenwood kg21@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 6th 2021

echo "Creating a comma delimited version of $1 ..." #prints what the function will do to the variable into the console
cat $1 | tr -s "\t" "," >> $1.csv 

# prints the variable which has been passed to the function, into the console($1)
# uses [tr -s "" ""] to replace one instance of something with another.
# in this case, replaces each tab (tab = \t) with a comma.
# '>>' appends the result of this to the .csv file of the variable which it creates.

echo "Done!" #Displays that the function has finished into the console
exit #marks that the function has ended