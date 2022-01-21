#!/bin/bash
# Author: Kayleigh Greenwood kg21@imperial.ac.uk
# Script: tifftopng.sh
# Description: converting .tif(and .tiff) files to .png
# Install Requirements: imagemagick
# Arguments: 0 (converts all tif files in the directory it is run in, doesnt need arguments)
# Output: New .png file (maintains old input file)
# Date: Oct 17th 2021

count=`ls -1 *.tif 2>/dev/null | wc -l` # sets the variable 'count' equal to the amount of .tif files in the current directory
if [ $count = 0 ] # if there are no tif files
then 
    echo -e "\nNo .tif files found to be converted.\n"
elif [ $count != 0 ] # if there are tif files
then
    for f in *.tif; # I have nested this for loop because when the script was run without tif files in the directory, it would try to run *.tif as a file. This ensures the loop is only run when there are .tif files presesnt.
    do  
        NewName="$(basename "$f")" # Removes path (for the purpose of checking if the converted file already exists)
        echo -e $"\nFile Found: $NewName \n"
        NewName2="${NewName%.*}" # Removes suffix (for the purpose of checking if the converted file already exists)
        echo -e $"New file name will be: $NewName2.png \n"
        if [ -f $NewName2.png ] # if the converted version of this file already exists
        then
            echo "Warning: File exists. Override it\n? [y/n]" # gives the user the option of continuing or stopping
            read a 
            echo
            if [ $a == y ] || [ $a == Y ] # if the user has entered y
            then
                echo -e "\nConverting $f\n"; 

                convert "$f" "$(basename "$f" .tif).png"; # converts file from tif to png
                echo -e "\nDone\n"
            else
                echo -e "\nProcces terminated. File not converted\n" # if user doesn't enter y, image isn't converted
            fi
        else # if converted version doesn't already exist, it is created
            echo -e "\nConverting $f\n"; 
            convert "$f" "$(basename "$f" .tif).png";

            echo -e "\nDone\n"
        fi
    done
fi
exit