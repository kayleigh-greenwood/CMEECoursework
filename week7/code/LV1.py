#!/usr/bin/env python3

"""Numerical integration for solving classical models in biology"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

## imports ##
import matplotlib.pylab as p
import numpy as np
import scipy as sc
import scipy.integrate as integrate
import sys

## functions ##

def dCR_dt(pops, t, r, a, z, e,):
    """Return growth rate of consumer and resource population at any given time step and produce relevant figures"""
    R = pops[0]
    C = pops[1]

    dRdt = r * R - a * R * C 
    # rate of change of resource population
    dCdt = -z * C + e * a * R * C
    # rate of change of consumer population
    

    return np.array([dRdt, dCdt])

def visfunc(t, pops):
    ## Figure 1
        f1 = p.figure()
        # opens empty figure object as f1
        p.plot(t, pops[:,0], 'g-', label='Resource density') 
        # plots time on x axis and population trajectories of resource population on y axis
        p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
        # plots time on x axis and population trajectories of consumer population on y axis
        p.grid()
        p.legend(loc='best')
        p.xlabel('Time')
        p.ylabel('Population density')
        p.title('Consumer-Resource population dynamics')
        f1.savefig('../results/LV_model.pdf') #Save figure
    ## figure 2
        f2 = p.figure()
        p.plot(pops[:,0], pops[:,1], 'r-')
        p.grid()
        p.xlabel('Resource density')
        p.ylabel('Consumer density')
        p.title('Consumer-Resource population dynamics')
        f2.savefig('../results/LV_model2.pdf')


def intfunc(Rpop=10, Cpop=5, tstart=0, tend=15, tinterval=1000, r=1., a=0.1, z=1.5, e=0.75):
    ## define time vector ##
    t = np.linspace(tstart, tend, tinterval)
    # linspace returns 1000 evenly spaced numbers over interval of 0 to 15
    print(Rpop)
    print(Cpop)
    ## numerically integrate the system forward ##
    RC0 = np.array([Rpop, Cpop])
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, args=(r, a, z, e), full_output=True)
    # integrate.odient produces two outputs, and they are assigned into pops and infodict
    # the two outputs are the array of population trajectories and the information about the output
    print(infodict['message'])

    ## visualize results 
    visfunc(t, pops)




def main(args):
    ## assign parameters
    if len(args)==10:
        print("Running script with inputted values.")

        # Rpop=int(args[1])
        # Cpop=int(args[2])
        # tstart=int(args[3])
        # tend=int(args[4])
        # tinterval=int(args[5])
        # r=float(args[6])
        # a=float(args[7])
        # z=float(args[8])
        # e=float(args[9])
        # intfunc(Rpop, Cpop, tstart, tend, tinterval, r, a, z, e)
        intfunc(int(args[1]), int(args[2]), int(args[3]), int(args[4]), int(args[5]), float(args[6]), float(args[7]), float(args[8]), float(args[9]))

    else:
        print("Running script with default values.")
        intfunc()
    


if __name__ == "__main__":
    # Make sure the "main" function is called from command line
    status =main(sys.argv)
    # directs the interpreter to pass the argument variables to the main function
    # sys.argv contains arguments given at command line
    sys.exit(status) #exits the program explicitly, returning an appropriate status code  (in this code, main states above that it will return 0, so 0 is returned)

## default
# Rpop=10, Cpop=5, tstart=0, tend=15, tinterval=1000, r=1., a=0.1, z=1.5, e=0.75
# test stats
# 15 4 0 50 100 2. 0.3, 2.5, 0.5

# TO DO: make sure all input parameters are of the same type
# TO DO : separate function into integration function and plotting function
# main runs integrate, which returns values, handle arguments that come in in main. check there are enough arguments