#!/bin/bash
# Author: Kayleigh Greenwood kg21@imperial.ac.uk
# Script: csvtospace.sh
# Description: substitutes commas with spaces.
#
# Saves the output into a .txt file
# Arguments: 1 -> comma delimited file
# Date: Oct 15th 2021

if [[ -f $1 ]] # if the user has inputted a file
then
    if grep -q "," "$1" # AND there are commas in this file
    then
        Filename=$(basename "$1") # removes path
        Filename2="${Filename%.*}" # removes suffix
        
        if [ -f ../results/$Filename2.txt ] # BUT the output file already exists in results
        then # ask the user to decide next step
            echo $" The intended output file, $Filename2.txt, already exists. Enter 1 to overwrite, 2 to append and 3 to abort."
            read a 
            if [ $a == 1 ]
            then # overwrite
                echo -e "\nRemoving commas in $Filename and replacing with spaces ...\n"

                cat $1 | tr -s "," " " > ../results/$Filename2.txt 
                # replaces commas with spaces and inputs the result into a new .txt file

                echo "$Filename2.txt overwritten."
                echo -e "\nDone!\n" #Displays that the function has finished into the console
            elif [ $a == 2 ]
            then # append
                echo -e "\nRemoving commas in $Filename and replacing with spaces ...\n"

                cat $1 | tr -s "," " " >> ../results/$Filename2.txt 
                # replaces commas with spaces and inputs the result into a new .txt file

                echo "Result appended to $Filename2.txt"
                echo -e "\nDone!\n" #Displays that the function has finished into the console
            else # abort
                echo -e "\n Operation aborted"
                exit
            fi
        else # output file doesnt exist, so convert and create
            echo -e "\nRemoving commas in $Filename and replacing with spaces ...\n"

            cat $1 | tr -s "," " " >> ../results/$Filename2.txt 
            # replaces commas with spaces and inputs the result into a new .txt file

            echo "$Filename2.txt created"
            echo -e "\nDone!\n" #Displays that the function has finished into the console
        fi
    else # if there aren't commas in the file
        echo "Error: No commas found in this file"
    fi
elif [ -z $1 ] # if the user has not input anything
then
    echo 'Error: Please input a file to be changed'
else # if the user has input something, but it isn't an existing file
    echo 'Error: Wrong input format. Please input existing files only.'
fi

exit #marks that the function has ended





















# what if someone input a .txt file and the input and output was the same location? the original file would be erased! can this be fixed?















# add error messages to deal with wrong or missing inputs
# run script on csv data files in Temperatures in master repository