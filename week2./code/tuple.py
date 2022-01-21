#!/usr/bin/env python3
"""Print out items from a tuple"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

## DATA ##
birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )


## SCRIPT ##   

for species in birds: print("\nLatin Name:", species[0], "\nCommon name:", species[1], "\nMass:", species[2] ,"\n")
