# Computing Week 7

This README file contains details about the scripts from classwork and practicals in CMEE week 7.

## Python 2

    LV1.py

**Summary:** Numerical integration for solving classical models in biology. Return growth rate of consumer and resource population at any given time step and produce relevant figures. <br />
**Input:** Has default parameter values but has option for user to specify R0, C0, tstart, tend, tinterval, r, a, z, e <br />
**Output:** LV_model_1_pop_dens_vs_time.pdf, LV_model_1_cons_dens_vs_res_dens.pdf  <br />
**Dependencies:** sys, matplotlib.pylab, scipy, numpy, scipy.integrate <br />
**Running Instructions:** python3 LV1.py<br /><br />

    profileme.py

**Summary:** Illustrative program introducing profiling <br />
**Input:** N/A <br />
**Output:** prints to terminal  <br />
**Dependencies:** sys <br />
**Running Instructions:** python3 profileme.py<br /><br />


    profileme2.py

**Summary:** Alternative illustrative program introducing profiling <br />
**Input:** N/A <br />
**Output:** prints to terminal  <br />
**Dependencies:** sys, numpy <br />
**Running Instructions:** python3 profileme2.py <br /><br />


    timeitme.py

**Summary:** Using timeit to figure out whether loops or list comprehensions are faster <br />
**Input:** N/A <br />
**Output:** prints to terminal  <br />
**Dependencies:** timeit <br />
**Running Instructions:** python3 timeitme.py<br /><br />


    LV2.py

**Summary:** Numerical integration for solving classical models in biology. Return growth rate of consumer and resource population at any given time step and produce relevant figures. <br />
**Input:**  Has default parameter values but has option for user to specify r, a, z, e <br />
**Output:** LV_model_2_pop_dens_vs_time.pdf, LV_model_2_cons_dens_vs_res_dens.pdf  <br />
**Dependencies:** sys, matplotlib.pylab, scipy, numpy, scipy.integrate <br />
**Running Instructions:** python3 LV2.py<br /><br />


    oaks_debugme.py

**Summary:** Has been debugged, accounting for corner cases <br />
**Input:** TestOaksData.csv <br />
**Output:** JustOaksData.csv <br />
**Dependencies:** csv, sys, doctest <br />
**Running Instructions:** python3 oaks_debugme.py<br /><br />

    TestR.R

**Summary:** Basic R script file <br />
**Input:** N/A <br />
**Output:** prints to terminal  <br />
**Dependencies:** N/A <br />
**Running Instructions:** Rscript TestR.R<br /><br />

    TestR.py

**Summary:** Python script to run an R script <br />
**Input:** TestR.R <br />
**Output:** TestR.Rout, TestR_errFile.Rout <br />
**Dependencies:** subprocess <br />
**Running Instructions:** python3 Test.py<br /><br />

## PYTHON GROUPWORK

    grp_oaks_debugme.py

**Summary:** Has been debugged, accounting for corner cases, and excluding the header row <br />
**Input:** TestOaksData.csv <br />
**Output:** JustOaksData.csv <br />
**Dependencies:** csv, sys, doctest<br />
**Running Instructions:** python3 grp_oaks <br /><br />

## JUPYTER

    MyFirstJupyterNB.ipynb

**Summary:** First Jupyter Notebook<br />
**Input:** N/A <br />
**Output:** N/A <br />
**Dependencies:**  <br />
**Running Instructions:** jupyter notebook MyFirstJupyterNb.ipynb <br /><br />
