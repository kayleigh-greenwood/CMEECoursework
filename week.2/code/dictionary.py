#!/usr/bin/env python3
"""populate a dictionary derived from taxa so that it maps order names to sets of taxa"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

## imports ##
from pprint import pprint

## data ##

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

## script ##

taxa_dic = {x[1]: [] for x in taxa} 
# creates dictionary called taxa_dic and assigns it the following:
# for every item in taxa, 
# create a key of the same name as it's second item (index 1).
# assign each key the value of an empty list

for species in taxa: # for each item in taxa,
    taxa_dic[species[1]].append(species[0]) 
    # locate the key with the same name as it's second item (eg Rodentia, Carnivora...)
    # and add the first item of species as the key's value

pprint(taxa_dic) # make each key print on a new line

