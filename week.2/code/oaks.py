#!/usr/bin/env python3

"""Examples of comprehensions"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'


## Finds just those taxa that are oak trees from a list of species

taxa = [ 'Quercus robur', 'Fraxinus excelsior', 'Pinus sylvestris', 'Quercus cerris', 'Quercus petraea', ]

def is_an_oak(name):
    """returns only oak species, those that start with quercus"""
    return name.lower().startswith('quercus ')

##Using for loops
print("\n", "Using for loops:")
oaks_loops = set() # creates empty set for oak species to populate
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species) # add only the oak species to the set
print(oaks_loops)

##Using list comprehensions
print("\n", "Using list comprehensions:")
oaks_lc = set([species for species in taxa if is_an_oak(species)])
print(oaks_lc)

##Get names in UPPER CASE using for loops
print("\n", "Using for loops:")
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species.upper()) # add only the oak species to the set, and convert to upper case
print(oaks_loops)

##Get names in UPPER CASE using list comprehensions
print("\n", "Using list comprehensions:")
oaks_lc = set([species.upper() for species in taxa if is_an_oak(species)])
print(oaks_lc)