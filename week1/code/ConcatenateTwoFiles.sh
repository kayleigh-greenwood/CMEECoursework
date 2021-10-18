#!/bin/bash
# Author: Kayleigh Greenwood kg21@imperial.ac.uk
# Script: ConcatenateTwoFiles.sh
# Description: Concatenates two files and assigns the output to a new file
#
# Saves the output into a new file, the name of which the user specifies
# Arguments: 3. $1 and $2 are the files to be concatenated and $3 is the new name of the output file which the script creates
# Date: Oct 16th 2021



if [ -z "$3" ] # if there has not been three arguments entered
then
    echo 'Error: Please enter three objects; two files to be concatenated and the desired name of the output file'
elif [ -f "$1" -a -f "$2" ] # if the first two arguments are both existing files (necessary for cat command)
then
    #user passes three arguments to the function: the two files to concatenate($1 and $2), and the variable they want the combination to be stored in ($3)
    cat $1 > ../results/$3 #assigns the value of the first inputted variable ($1) to the third inputted variable ($3) which replaces any prior content/value.
    cat $2 >> ../results/$3 #appends the value of the second inputted variable ($2) to the $3 variable
    # the contents of the two inputted variables have been added to $3

    echo -e "\nMerged File is called $3 and contains:\n" #Prints statement to console
    cat ../results/$3

    #prints the value of the variable $3 to the console, which contains the contents of the first inputted variable ($1) followed by the second ($2).
else
    echo -e 'Error: Wrong input type. The first two inputs must be existing files.\n'
fi 




