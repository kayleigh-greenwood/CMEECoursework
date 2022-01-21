#!/usr/bin/env python3

"""Use list comprehensions and loops to make lists from bird data"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

# DATA 
birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

# SCRIPT

## LATIN NAMES ##

### loop version ###

# bird_latin = []
# for species in birds:
#     bird_latin.append(species[0])

# print(bird_latin)

### lc version ###

print("\n","Latin names:")
bird_latin = [species[0] for species in birds] # for each tuple in birds, append the first item of each tuple to the list 'bird_latin'
print(bird_latin)

## NORMAL NAMES ##

### For loop ###

# normal_names = []
# for species in birds:
#     normal_names.append(species[1])

# print(normal_names)


### list comprehension ###

print("\n","Common names:")
normal_names = [species[1] for species in birds] # same as above, adding the second item in each tuple instead
print(normal_names)

## BODY MASS ##

### for loops ###

# body_mass = []
# for species in birds:
#     body_mass.append(species[2])

# print(body_mass)

### list comprehension ###

print("\n","Body mass:")
body_mass = [species[2] for species in birds] # same as above, adding the third item from each tuple instead
print(body_mass)

exit
 