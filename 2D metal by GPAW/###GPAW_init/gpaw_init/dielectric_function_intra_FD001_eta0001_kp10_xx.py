from ase import Atoms
from ase.lattice.hexagonal import Hexagonal
from ase.io import read, write
import matplotlib.pyplot as plt

from gpaw import GPAW, PW, FermiDirac
from gpaw.response.df import DielectricFunction
from gpaw.mpi import world
from gpaw.bztools import find_high_symmetry_monkhorst_pack

# 1) Ground-state.


atoms = read('sample.xyz')


calc = GPAW(mode=PW(600),
            xc='PBE',
            occupations=FermiDirac(width=0.01),
            kpts={'density': 10})

atoms.calc = calc
atoms.get_potential_energy()
calc.write('gs.gpw')

# 2) Unoccupied bands

kpts = find_high_symmetry_monkhorst_pack('gs.gpw', density=10.0)

responseGS = GPAW('gs.gpw').fixed_density(
    kpts=kpts,
    parallel={'band': 1},
    nbands=80,
    convergence={'bands': 70})

responseGS.get_potential_energy()
responseGS.write('gsresponse.gpw', 'all')

# 3) Dielectric function

df = DielectricFunction(
    'gsresponse.gpw',
    eta=1e-3,
    rate='eta',
    intraband=True,
    frequencies={'type': 'nonlinear', 'domega0': 0.01},
    integrationmode='tetrahedron integration')

df1tetra_w, df2tetra_w = df.get_dielectric_function(filename='df_sample_xx.csv', direction='x')

dfpola1, dfpola2 = df.get_polarizability(filename='pola_sample_xx.csv', direction='x')

omega_w = df.get_frequencies()
