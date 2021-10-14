#!/usr/bin/env python3
# shebang line to tell computer where to look for python.
# isn't always absolutely necessary, but good practice

""" Description of this program or application.
You can use several lines"""
# docstring describes operation of the script, serves as documentation for the code
# tells user how to use the python code

__appname__ = '[application name here]'
__autor__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

# __ signals an internal variable, reserved for python's own purposes

## imports ##
import sys # sys is a module that interfaces our program with the operating system

## constants ##

##functions##
def main():
    """ Main entry point of the program"""
    print('This is a boilerplate') # NOTE: indented using two tabs or 4 spaces
    return 0

# main function
# arguments obtained from the 'if name main' sections are passed here

if __name__ == "__main__":
    """Makes sure the "main" function is called from command line"""
    status = main()
    sys.exit(status)