#!/usr/bin/env python3

"""Numerical integration for solving classical models in biology.
Return growth rate of consumer and resource population at any given time step
and produce relevant figures"""

__author__ = 'Kayleigh Greenwood (kayleigh.greenwood21@imperial.ac.uk)'
__version__ = '0.0.1'

## imports ##
import matplotlib.pylab as p
import numpy as np
import scipy as sc
import scipy.integrate as integrate
import sys

## functions ##

def dCR_dt(pops, t, r, a, z, e):
    """Return growth rate of consumer and resource population at any given time step """
    R = pops[0]
    C = pops[1]
    K = 80
    # K changes depending on environment
    # K is the carrying capacity that an environment has for a certain species
    dRdt = r * R * (1 - (R/K)) - a * R * C 
        # rate of change of resource population
    dCdt = -z * C + e * a * R * C
        # rate of change of consumer population

    return np.array([dRdt, dCdt])

def visfunc(t, pops, r, a, z, e):
    """Creates plots from population parameters"""

    ## figure 1
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
        p.title(f'Consumer-Resource population dynamics \n r = {r}, a = {a}, z = {z}, e = {e}')
        f1.savefig('../results/LV_model_2_pop_dens_vs_time.pdf') #Save figure
        print("Figure of Population density vs. Time saved to results.")

    ## figure 2
        f2 = p.figure()
        p.plot(pops[:,0], pops[:,1], 'r-')
        p.grid()
        p.xlabel('Resource density')
        p.ylabel('Consumer density')
        p.title(f'Consumer-Resource population dynamics \n r = {r}, a = {a}, z = {z}, e = {e}')
        f2.savefig('../results/LV_model_2_cons_dens_vs_res_dens.pdf')
        print("Figure of Consumer density vs Resource density saved to results.")



def intfunc(r=1., a=0.1, z=1.5, e=0.75):
    """ Carries out integration """

    ## states what will be run
        print(f"Running LV2.py with r={r}, a={a}, z={z}, e={e}")
    ## defines parameters
        Rpop = 10
        Cpop = 5
    ## define time vector
        t = np.linspace(0, 60, 1000)
            # linspace returns 1000 evenly spaced numbers over interval of 0 to 15
    ## numerically integrate the system forward ##
        RC0 = np.array([Rpop, Cpop])
        pops, infodict = integrate.odeint(dCR_dt, RC0, t, args=(r, a, z, e), full_output=True)
            # integrate.odient produces two outputs, and they are assigned into pops and infodict
            # the two outputs are the array of population trajectories and the information about the output
        print(infodict['message'])
    ## visualize results 
        visfunc(t, pops, r, a, z, e)
    ## determine final population values
        final_resource_pop = pops[(len(t)-1),0]
        final_consumer_pop = pops[(len(t)-1),1]

    ## print final population values
        print(f'Final population value for Resource population: {final_resource_pop} ')
        print(f'Final population value for Consumer population: {final_consumer_pop} ')


def main(args):
    """Main entry point: Detemine which parameters to run script with"""
    ## assign parameters
    if len(args)>=5:
        try:
            # if user has entered all required parameters
            print("Running script with inputted r, a, z, e values. \n")
            intfunc(float(args[1]), float(args[2]), float(args[3]), float(args[4]))
        except:
            # if user has entered enough required parameters but of wrong format
            print("Error: input parameters of the wrong format.")
            print("Please enter, in order:")
            print("r - intrinsic(per-capita) growth rate (float/integer) \n a - encounter and consumption rate of the consumer on the resource (float/integer) \n z - mortality rate of consumer (float/integer) \n e - consumer's efficiency in converting resource to consumer biomass (float/integer) \n")
    elif len(args)>1:
            # if user has entered parameters, but not enough
            print("Error: not enough input parameters.", "\n")
            print("Please enter, in order:", "\n")
            print("r - intrinsic(per-capita) growth rate (float/integer) \n a - encounter and consumption rate of the consumer on the resource (float/integer) \n z - mortality rate of consumer (float/integer) \n e - consumer's efficiency in converting resource to consumer biomass (float/integer) \n")
    else:
        # if user has entered no parameters
        print("Running script with default values.")
        intfunc()
    


if __name__ == "__main__":
    # Make sure the "main" function is called from command line
    status =main(sys.argv)
    # directs the interpreter to pass the argument variables to the main function
    # sys.argv contains arguments given at command line
    sys.exit(status) #exits the program explicitly, returning an appropriate status code  (in this code, main states above that it will return 0, so 0 is returned)
