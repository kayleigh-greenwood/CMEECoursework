#!/usr/bin/env python3

"""Store objects for later use"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'


# IMPORTS

import pickle


##################
# STORING OBJECTS
##################

# To save an object (even complex) for later use
my_dictionary = {"a key":10, "another key": 11} # create a dictionary

f = open('../sandbox/testp.p', 'wb') # w: open to write, b: accept binary(machine readable but not human readable) files
pickle.dump(my_dictionary, f) # stores the object inside testp.p
f.close()

## Load the data again
f = open('../sandbox/testp.p', 'rb') # only needs reaed permission as is loading the data not manipulating it
another_dictionary = pickle.load(f) # loads the data into a new variable
f.close()

print(another_dictionary) # because the data was stored in a variable, it remains available after f.close()


