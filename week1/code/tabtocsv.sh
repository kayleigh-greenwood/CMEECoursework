#!/bin/bash
# Author: Kayleigh Greenwood kg21@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 6th 2021


if [[ -f $1 ]] # if the user has inputted a file
then
    if grep -q "    " "$1"
    then
        Filename=$(basename "$1") # removes path
        Filename2="${Filename%.*}" # removes suffix
        if [ -f ../results/$Filename2.csv ] # BUT the output file already exists in results
        then # ask the user to decide next step
            echo $" The intended output file, $Filename2.csv, already exists. Enter 1 to overwrite, 2 to append and 3 to abort."
            read a 
            if [ $a == 1 ]
            then #overwrite
                echo -e "\nRemoving tabs in $Filename and replacing with spaces ...\n" #prints what the function will do to the variable into the console

                cat $1 | tr -s "\t" "," > ../results/$Filename2.csv #../results/ before basename
                echo "$Filename2.csv overwritten."
                echo -e "\nDone!\n" #Displays that the function has finished into the console
            elif [ $a == 2 ]
            then #append
                echo -e "\nRemoving tabs in $Filename and replacing with spaces ...\n" #prints what the function will do to the variable into the console

                cat $1 | tr -s "\t" "," >> ../results/$Filename2.csv #../results/ before basename
                echo "Results appended to $Filename2.csv."
                echo -e "\nDone!\n" #Displays that the function has finished into the console
            else # abort
                echo -e "\n Operation aborted"
                exit
            fi
        else
            echo -e "\nRemoving tabs in $Filename and replacing with spaces ...\n"

            cat $1 | tr -s "," " " >> ../results/$Filename2.csv
            # replaces commas with spaces and inputs the result into a new .txt file

            echo "$Filename2.csv created"

            echo "Done!" #Displays that the function has finished into the console
        fi
    else # if there aren't tabs in the file
        echo "Error: No tabs found in this file"
    fi
elif [ -z $1 ] # if the user hasn't entered anything
then
    echo 'Error: Please input a file to be changed'
else # if the user has entered something but it isn't an existing file
    echo 'Error: Wrong input format. Please input existing files only.'
fi


exit #marks that the function has ended

# uses [tr -s "" ""] to replace one instance of something with another.
# in this case, replaces each tab (tab = \t) with a comma.
# '>>' appends the result of this to a .csv file of the filename which was passed to it.
# uses Filename 2 to create the new file

