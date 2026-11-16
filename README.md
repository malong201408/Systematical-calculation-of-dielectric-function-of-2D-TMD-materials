# Systematical-calculation-of-dielectric-function-of-2D-TMD-materials
This code takes the 2D structures in C2DB database and systematically calculate the dielectric functions and near field transfer power between mononlayers

Necessary apps or packages before initiate the code: VASP, GPAW, python, VASPkit. 

All files have to be in one folder with ###_VASP_init (###GPAW_init) for VASP(GAPW) running.

Download the configurations from C2DB database, store the original files in Name folder in ###_VASP_init. Then use ZZname.sh file to translate them into POSCAR files. Copy and paste the new files into POSCAR folder. 

VASP (for semiconductors): 
Back to the main folder. Run 1_XXX to 5_XXX to initiate the VAPS calculation, which includes lattice relaxation, self-consistent field (SCF) calculation, band structure calculation, isolated particle approximation (IPA) and random phase calculation (Chi). For 4th and 5th step, adjust the parameters based on the instruction in the page https://vasp.at/wiki/Dielectric_properties_of_SiC. 

Run 201_DOS, 301_band, 401_plasma, 501_Chi for DOS, band structure, plasma frequency, and real(imaginary) dielectric function \varepsilon for each candidate. Run 502_sig to convert dielectric function to surface conductivities. Run 503_sig12 to extract only the small frequency responses. 

Run 6_Qfn to initiate the near field calculation by using the well established Mathematica code Qfn.m

601_Q20 and 602_HTP give the ready-to-plot Origin data that is for the near field radiative power in terms of separation distance (2-2000 A) for evanescent, propagate, and total mode contributions. 

GPAW (for metals):

