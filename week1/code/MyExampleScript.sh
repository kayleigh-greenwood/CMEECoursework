#!/bin/bash

msg1="Hello" #Creates the variable 'msg1' and assins it the value of a "Hello" string
msg2=$USER #creates the variable 'msg2' and assigns it the value of the $USER environment variable
echo "$msg1 $msg2" #Greets the user by printing the values of msg1(Hello) and msg2(user) into the console
echo "Hello $USER" #Another way of greeting the user in the console without assigning hello to a variable
echo #Prints an empty line to the console