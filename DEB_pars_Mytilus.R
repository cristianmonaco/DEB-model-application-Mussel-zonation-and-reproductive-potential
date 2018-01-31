## DEB parameter list - Mytilus galloprovncialis ####

# Specify parameter values

#author = cristianmonaco
############################################################################################################

## Primary Parameters - DEBtool (Table 2 in paper)

# Feeding
# Max. feeding rate, {pXm} (J/cm2.h) -- Matlab routines
p_Xm <- 9.4225 / 24

# Assimilation efficiency, ae (-) -- Morgana data, Matlab routines
ae <- 0.8
# Half saturation coefficient, K (ug/l) -- Morgana data
K <- 2.1

# Energetic
# Volume specific cost for structure, [EG] (J/cm3) -- Matlab routines
E_G <- 3156
# Max. storage density or reserve capacity, [Em] (J/cm3) -- Matlab routines, {pAm} / v 
E_m <- 545.8389
# Volume specific maintenance costs, [pM] (J/cm3.h) -- Matlab routines
p_M <-  10.27 / 24
# Fraction of energy allocated to growth, kappa (-) -- Matlab routines 
kap <- 0.4699
# Fraction of energy used for spawning, kappa_R (-) -- Matlab routines 
kap_R <- 0.9977

# Length conversions
# Shape coefficient adult (-) 
del_M <- 0.22

# Mass conversions
# Density of structure assuming dry weight, dV (g/cm3)
d_V <- 0.09
# Reserve energy content, AFDW (J/g) (Brody 1945, Troost et al 2010)
mu_E <- 17500
# Weight-energy coupler, rho_E (gDW/J) -- from Marko Jusup's tuna paper
rho_E <- 1/mu_E

# Life stage transition thresholds, structural volumes
# Scaled length at birth, metamorphosis, and puberty (cm)
L_b <- 0.0019
L_j <- 0.0197
L_p <- 0.6912
# Structural volume at birth (cm3) -- Matlab routines 
V_b <- L_b^3
# Maturity at birth, J (EHb) -- Matlab routines
E_Hb <- 2.4830e-05
# Reserve at birth, J (E0) -- Matlab routines (E0=uE0*g*[Em]*Lm^3)
uE0 <- 1.8501e-07
g <- E_G/ (kap * E_m)
L_m <- 0.3449
E_0 <- uE0 * g * E_m * L_m^3
# Structural volume at puberty (cm3) -- Matlab routines
V_p <- L_p^3
# Maturity at puberty, J (EHp) -- Matlab routines
E_Hp <- 608.8

# Secondary parameters
# Energy investment ration, g (-): [EG]/kap*[Em]
g <- E_G/ (kap * E_m)
# Somatic maintenance rate coefficient, kM (1/h): [pM]/[EG]
k_M <- p_M/ E_G
# Maturity maintenance rate coefficient, kJ (1/h)
k_J <- 0.02/ 24
# Energy conductance, v (cm/h): {pAm}/[Em]
v.ref <- 0.01381 / 24
# Yield of structure on reserve, y_VE (C-moles)
y_V_E <- 0.6563

# Temperature Correction Parameters
TA <- 10590
TL <- 279.6
TH <- 306.1
TAL <- 22670
TAH <- 34540

met_dep <- 0.15     # Based on average O2 consumption reduction on air vs water (Tagliarolo McQuaid 2015)
