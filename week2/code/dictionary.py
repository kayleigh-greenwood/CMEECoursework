#!/usr/bin/env python3
"""populate a dictionary derived from taxa so that it maps order names to sets of taxa"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

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

## instructions ##
# write a short python script DONE
# to populate a dictionary called taxa_dic
# derived from taxa
# so that it maps order names
# to sets of taxa

## notes to help ##
# dictionary = hash table of key value pairs enclosed by curly braces - key can be number or string, value can be any python object
# example format: GenomeSize = {'Homo Sapients': 3200, 'E.coli': 4600}


## script ##

# taxa_dic = dict.fromkeys(['Afrosoricida','Carnivora','Chiroptera','Rodentia'], [])
taxa_dic = {x[1]: [] for x in taxa}

print(taxa_dic)

for species in taxa:
    taxa_dic[species[1]].append(species[0])

print(taxa_dic)

