## DEB parameter list - Perna perna ####

# Specify parameter values

#author = cristianmonaco
############################################################################################################


# Primary parameters ------------------------------------------------------

# Feeding
# Max. feeding rate, {pXm} (J/cm2.h) -- Matlab routines
p_Xm <- 15.5423 / 24
# Assimilation efficiency, ae (-) -- Morgana data, Matlab routines
ae <- 0.69
# Half saturation coefficient, K (ug/l) -- Morgana data
K <- 0.5

# Energetic
# Volume specific cost for structure, [EG] (J/cm3) -- Matlab routines
E_G <- 2800
# Max. storage density or reserve capacity, [Em] (J/cm3) -- Matlab routines, {pAm} / v 
E_m <- 3533.5
# Volume specific maintenance costs, [pM] (J/cm3.h) -- Matlab routines
p_M <-  29.07 / 24
# Fraction of energy allocated to growth, kappa (-) -- Matlab routines 
kap <- 0.8189
# Fraction of energy used for spawning, kappa_R (-) -- Matlab routines 
kap_R <- 0.95

# Length conversions
# Shape coefficient adult (-) 
del_M <- 0.2258

# Mass conversions
# Density of structure assuming dry weight, dV (g/cm3)
d_V <- 0.09
# Reserve energy content, AFDW (J/g) (Brody 1945, Troost et al 2010)
mu_E <- 17500
# Weight-energy coupler, rho_E (gDW/J) -- from Marko Jusup's tuna paper
rho_E <- 1/mu_E

# Life stage transition thresholds, structural volumes
# Scaled length at birth, metamorphosis, and puberty (cm)
L_b <- 0.0021
L_j <- 0.0242
L_p <- 0.6729
# Structural volume at birth (cm3) -- Matlab routines 
V_b <- L_b^3
# Maturity at birth, J (EHb) -- Matlab routines
E_Hb <- 5.595e-06
# Reserve at birth, J (E0) -- Matlab routines (E0=uE0*g*[Em]*Lm^3)
uE0 <- 5.9699e-07
g <- E_G/ (kap * E_m)
L_m <- 0.31
E_0 <- uE0 * g * E_m * L_m^3
# Structural volume at puberty (cm3) -- Matlab routines
V_p <- L_p^3
# Maturity at puberty, J (EHp) -- Matlab routines
E_Hp <- 255.2

# Secondary parameters
# Energy investment ration, g (-): [EG]/kap*[Em]
g <- E_G/ (kap * E_m)
# Somatic maintenance rate coefficient, kM (1/h): [pM]/[EG]
k_M <- p_M/ E_G
# Maturity maintenance rate coefficient, kJ (1/h)
k_J <- 0.001112/ 24
# Energy conductance, v (cm/h): {pAm}/[Em]
v.ref <- 0.003035 / 24
# Yield of structure on reserve, y_VE (C-moles)
y_V_E <- 0.7397

# Temperature Correction Parameters
TA <- 9826
TL <- 273
TH <- 309
TAL <- 55400
TAH <- 250600

met_dep <- 0.33     # Based on average O2 consumption reduction on air vs water (Tagliarolo McQuaid 2015)
