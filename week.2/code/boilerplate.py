#!/usr/bin/env python3
# shebang line to tell computer where to look for python.
# isn't always absolutely necessary, but good practice

""" Description of this program or application.
You can use several lines"""
# docstring describes operation of the script, serves as documentation for the code
# tells user how to use the python code

__appname__ = '[application name here]'
__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

# __ signals an internal variable, reserved for python's own purposes

## imports ##
import sys # sys is a module that interfaces our program with the operating system

## constants ##

##functions##
def main(argv):
    """ Main entry point of the program"""
    print('This is a boilerplate') # NOTE: indented using two tabs or 4 spaces
    return 0

# main function
# arguments obtained from the 'if name main' sections are passed here.
# so if the script is being run by itself, it will get its arguments from the 'if name main' section
# however, if the script has been imported into another script, argv will mean the arguments are obtained from the main script, and not this one.

if __name__ == "__main__":
    """Makes sure the "main" function is called from command line"""
    status = main(sys.argv) # directs the interpreter to pass the argument variables to the main function
    sys.exit(status) #exits the program explicitly, returning an appropriate status code  (in this code, main states above that it will return 0, so 0 is returned)

# if __name__ = "__main__"
    # adding this code at the end of your module sets __name__ to "__main__"
    # this makes the file usable as a script as well as an importable module.
    # this is important for packaging and reusability
    # if this file is being run by itself, the code beneath the if statement will run
    # if this file has been imported by another module, __name__ will be set to something else (boilerplate), so the code beneath the if statement will not run

# status
    # sets the command being run as a variable
    # this allows sys.exit() to be used on the command

# why 'sys.argv' and not 'argv'
    # argv is a variable that holds the ARGUMENTS passed to the script
    # sys.argv is an object containing the names of the ARGUMENTS in the script
    # in this situation, if there are no arguments, the argv function will pass the name of the script, as index [0] of argv is the name of the script


# sys.argv
    # argv is the argument variable which holds the arguments you pass to the python script whrn you run it
    # argv is an object (created by python using the sys module imported at the beginning) which contains the names of the argument variables in the current script