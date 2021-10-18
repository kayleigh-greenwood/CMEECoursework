#!/bin/bash
# Author: Kayleigh Greenwood kg21@imperial.ac.uk
# Script: variables.sh
# Description: Illustrates the use of variables, changes the name of a string, and computes the sum of two numbers
#
# Prints outputs into the terminal
# Arguments: 0
# Date: Oct 17th 2021

# Special variables
echo 
echo "This script was called with $# parameters"
echo "This script's name is $0"
echo "The arguments are $@"
echo "The first argument is $1"
echo "The second argument is $2"


# Assigned variables; Explicit declaration:
MY_VAR='some string' #Creates the variable(MyVar) and assigns it a value (some string)
echo 'the current value of the variable is:' $MY_VAR #Prints the value of the variable in the console
echo
echo 'Please enter a new string' #Asks user to re-assign a value to the variable
read MY_VAR #Tells the programme that the value the user enters on this line is the new value of the 'MyVar' variable
echo
 
if [[ $MY_VAR == "" ]]
then
    echo "ERROR: No string entered"
else
    echo -e 'You have changed the current value of the variable to:' $MY_VAR '\n' #prints the variable's new value in the console
fi 

## Assigned variables; Reading (multiple values) from user input:
echo 'Enter two integers separated by a space(s)' #prints instructions for user in console
read a b #Tells the programme that the two numbers entered by the user are the values for the new variables a and b, respectively
echo

INPUTS=($a$b)


ONLY_NUMBERS=$(printf '%s\n' "${INPUTS//[[:digit:]]/}" | wc -w)  # checks if there are anything other than numbers in the string. returns the amount of none-number things in the string


if (( $ONLY_NUMBERS > 0 )) # checks if the user has entered anything but integers
then
    echo "ERROR: there are letters present. Please only enter 2 integers"
elif [ -z $b ] # makes sure the user has entered at least 2 integers
then
    echo "ERROR: Not enough integers entered. Please enter 2 integers"

else
    MY_SUM=$(expr $a + $b) #stores the sum of variables a and b into a new variable 'mysum' using expr command.
    echo 'You entered' $a 'and' $b'.' 
    echo 'Their sum is:' $MY_SUM
fi

exit
