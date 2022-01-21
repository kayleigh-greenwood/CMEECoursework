#!/usr/bin/env python3

########## UNFINISHED ################
"""Run LV1.py and LV2.py"""

# FW: Not sure if this all needs a bit of fiddling with, but it is the basic priciple
# Then use pstats to extract the relevant information if you want

## imports
import LV1
import LV2

import cProfile

## code
# cProfile.run(LV2.main())

LV1.main()
LV2.main()