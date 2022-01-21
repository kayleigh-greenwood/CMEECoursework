"""get_TreeHeight is a python script that calculates tree heights"""

__appname__ = 'get_TreeHeight.py' 
__author__ = 'Peter (Guancheng) Zeng (pz221@ic.ac.uk), Kate Griffin (kate.griffin21@imperial.ac.uk), Junyue Zhang (jz1621@ic.ac.uk), Kayleigh Greenwood (Kayleigh.Greenwood21@ic.ac.uk)'
__version__ = '0.0.1'


### import ###
import sys
import pandas
import numpy

treeData = pandas.read_csv("../data/" + sys.argv[1] + ".csv")

### to calculate the height for every rows ###
for row in treeData:
    treeData["Tree.Height.m"] = treeData["Distance.m"] * numpy.tan(treeData["Angle.degrees"] * numpy.pi/180)

### output the data to the tree data csv
treeData.to_csv("../results/" + sys.argv[1] + "_TreeHts_py.csv", sep= ',',index=False)