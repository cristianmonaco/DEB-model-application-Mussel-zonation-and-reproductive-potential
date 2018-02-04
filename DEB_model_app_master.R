##  DEB model application for Perna perna and Mytilus galloprovincialis - Mussel Zonation and Reproductive Potential ##

  # User can change: species, site, level, climate change scenario 
  # Parameters from DEBtool_M
  # Environmental data is for one year (Oct 2015-Oct 2016)
  # To estimate ultimate size under specific conditions, the time window is muliplied X10
  # Rates are in per hour (/h)

# Author: cristianmonaco
###############################################################################

# Housekeeping ------------------------------------------------------------
rm(list=ls())

# Load packages -----------------------------------------------------------
library(zoo)

# Load environmental data -------------------------------------------------
load(file = "env.Rda")


# Load user input ---------------------------------------------------------
source("user_input.R")


# Mussel height (estimated and +0.3, m above MLLW) ---------------------------------
  # Thresholds Brenton: High = 1.21 m, Mid = 1.04 m, Low = 0.91 m.
  # Thresholds Plett: High = 1.11 m, Mid = 1.01 m, Low = 0.85 m.
  # Thresholds Keurbooms: High = 1.39 m, Mid = 1.01, Low = 0.91 m.
height <- ifelse(site == "BR" & level == "Low", 0.91,
            ifelse(site == "BR" & level == "Mid", 1.04,
            ifelse(site == "BR" & level == "High", 1.21,
            ifelse(site == "PT" & level == "Low", 0.85,
            ifelse(site == "PT" & level == "Mid", 1.01,
            ifelse(site == "PT" & level == "High", 1.11, 
            ifelse(site == "KB" & level == "Low", 0.91,
            ifelse(site == "KB" & level == "Mid", 1.01,
            site == "KB" & level == "High", 1.39))))))))


# Submergence and aerial exposure -----------------------------------------
tide <- env$tides
tide_threshold <- ifelse(tide >= height, 1, 0)
tide_threshold <- as.vector(coredata(tide_threshold))

tide_threshold <- rep(tide_threshold, n_years)               # MULTIPLY TIME WINDOW FOR MORE YEARS
tide <- rep(as.vector(coredata(tide)), n_years)              # MULTIPLY TIME WINDOW FOR MORE YEARS

# Percent aerial exposure
100-round(100*sum(tide_threshold)/ length(tide_threshold), 2)


# Body temperature --------------------------------------------------------
Tbody <- ifelse(site == "BR" & species == "Perna" & level == "Low", as.vector(coredata(env$Tbody_BR_Perna_Low)) + 273,
              ifelse(site == "BR" & species == "Perna" & level == "Mid", as.vector(coredata(env$Tbody_BR_Perna_Mid)) + 273,
              ifelse(site == "BR" & species == "Mytilus" & level == "Mid", as.vector(coredata(env$Tbody_BR_Myt_Mid)) + 273,
              ifelse(site == "BR" & species == "Mytilus" & level == "High", as.vector(coredata(env$Tbody_BR_Myt_High)) + 273,
              
              ifelse(site == "PT" & species == "Perna" & level == "Low", as.vector(coredata(env$Tbody_PT_Perna_Low)) + 273,
              ifelse(site == "PT" & species == "Perna" & level == "Mid", as.vector(coredata(env$Tbody_PT_Perna_Mid)) + 273,
              ifelse(site == "PT" & species == "Mytilus" & level == "Mid", as.vector(coredata(env$Tbody_PT_Myt_Mid)) + 273,
              ifelse(site == "PT" & species == "Mytilus" & level == "High", as.vector(coredata(env$Tbody_PT_Myt_High)) + 273,
              
              ifelse(site == "KB" & species == "Perna" & level == "Low", as.vector(coredata(env$Tbody_KB_Perna_Low)) + 273,
              ifelse(site == "KB" & species == "Perna" & level == "Mid", as.vector(coredata(env$Tbody_KB_Perna_Mid)) + 273,
              ifelse(site == "KB" & species == "Mytilus" & level == "Mid", as.vector(coredata(env$Tbody_KB_Myt_Mid)) + 273,       
              as.vector(coredata(env$Tbody_KB_Myt_High)) + 273)))))))))))

# Consider climate change scenarios ---------------------------------------
Tbody_current <- Tbody
TbodyRCP8.5_air <- ifelse(tide_threshold == 1, Tbody, Tbody+3.5)
TbodyRCP8.5_water <- ifelse(tide_threshold == 1, Tbody+2.01, Tbody)
TbodyRCP8.5_air_water <- ifelse(tide_threshold == 1, Tbody+2.01, Tbody+3.5)

Tbody <- ifelse(ccs == "RCP8.5_air", TbodyRCP8.5_air, 
                ifelse(ccs == "RCP8.5_water", TbodyRCP8.5_water,
                ifelse(ccs == "RCP8.5_air_water", TbodyRCP8.5_air_water,
                Tbody_current)))

Tbody <- rep(Tbody, n_years)                 # MULTIPLY TIME WINDOW FOR MORE YEARS

# Food density, X (ugChl-a/l ----------------------------------------------
X <- ifelse(site == "BR", as.vector(coredata(env$MODISAqua_BR)),
            ifelse(site == "PT", as.vector(coredata(env$MODISAqua_PT)),
            as.vector(coredata(env$MODISAqua_KB))))


X <- rep(X, n_years)                         # MULTIPLY TIME WINDOW FOR MORE YEARS


# Run DEB model -----------------------------------------------------------

# Call parameter values ---------------------------------------------------
pars <- ifelse(species[1] == "Perna", "DEB_pars_Perna.R", "DEB_pars_Mytilus.R") 
source(pars)


# Temperature Correction Function
source("TC_fun.R")
TC <- TC_fun(Tbody, tide_threshold, TA, TAH, TAL, TH, TL, met_dep)


# Time (1 HOUR intervals)
time <- seq.int(1, length(Tbody), length=length(Tbody))


# Specify Equations for DEB fluxes, state variables, and outputs ----------
f <- vector(length = length(Tbody))
E.dens <- vector(length = length(Tbody))
sM <- vector(length = length(Tbody))
v <- vector(length = length(Tbody))
p_Xm_TC <- vector(length = length(Tbody))
p_Am <- vector(length = length(Tbody))
pA <- vector(length = length(Tbody))
pC <- vector(length = length(Tbody))
pG <- vector(length = length(Tbody))
p_M_TC <- vector(length = length(Tbody))
pM <- vector(length = length(Tbody))
pJ <- vector(length = length(Tbody))
pR <- vector(length = length(Tbody))
E_egg <- vector(length = length(Tbody))
L <- vector(length = length(Tbody))
Www <- vector(length = length(Tbody))
Wdw <- vector(length = length(Tbody))
Wsdw <- vector(length = length(Tbody))
Wgdw <- vector(length = length(Tbody))
GSI <- vector(length = length(Tbody))
GSI[1] <- 0                               
dgam.dt <- vector(length = length(Tbody))
gam <- vector(length = length(Tbody))
gam[1] <- 0
E <- vector(length = length(Tbody))
E[1] <- 1834.921                                     # 4 cm MID SHORE ANIMAL
# E[1] <- E_0
dE.dt <- vector(length = length(Tbody))
V <- vector(length = length(Tbody))
V[1] <- 0.7369011                                     # 4 cm MID SHORE ANIMAL
# V[1] <- V_b
dV.dt <- vector(length = length(Tbody))
ER <- vector(length = length(Tbody))
ER[1] <- 0                                     
dER.dt <- vector(length = length(Tbody))
eggs <- vector(length = length(Tbody))


# Calculate the variables using a loop that integrates them all -----------
for(t in 1:length(Tbody)) {
  
  # Scaled Functional Response (-)
  f[t] <- X[t]/ (X[t] + K)
  f[t] <- ifelse(tide_threshold[t] == 1, f[t], 0)
  
  # Energy density, [E] (J/cm3)
  E.dens[t] <- E[t]/ (V[t]) 
  
  # Energy fluxes    
  # Acceleration factor (-)
  sM[t] <- min(V[t]^(1/3), L_j) / L_b
  
  # Energy conductance
  v[t] <- v.ref * sM[t]
  
  # Max. assimilation rate, {pAm} (J/cm2.h)
  p_Xm_TC[t] <- TC[t] * p_Xm
  p_Am[t] <- p_Xm_TC[t] * ae * sM[t]
  
  # Assimilation, pA (J/h)      
  pA[t] <- p_Am[t] * f[t] * V[t]^(2/3)
  
  # Somatic maintenance, pM (J/h)
  p_M_TC[t] <- TC[t] * p_M
  pM[t] <- p_M_TC[t] * V[t]
  
  # Catabolic utilization, pC (J/h)
  pC[t] <- (E.dens[t]/ (E_G + kap * E.dens[t])) * (((E_G * p_Am[t] * V[t]^(2/3)) / E_m) + pM[t])
  
  # Growth, pG (J/h)
  pG[t] <- kap * pC[t] - pM[t]      
  
  # Maturity maintenance, pJ (J/h)
  pJ[t] <-  TC[t] * min(((1-kap)/ (kap)) * V[t] * p_M, ((1-kap)/ (kap)) * V_p * p_M)
  
  # Reproduction, pR (J/d) 
  pR[t] <- (1 - kap) * pC[t] - pJ[t]  
  
  # State variables dynamics (Reserves, Structure, Reproduction, Gametes)
  # Reserves, E (J)
  dE.dt[t] <- pA[t] - pC[t]
  # Structure, V (cm3)
  dV.dt[t] <- pG[t]/ E_G
  # Reproduction, ER (J)
  dER.dt[t]  <- ifelse(V[t] > V_p, pR[t], 0)
  # Gamete production, dgam/dt (J)
  dgam.dt[t] <- dER.dt[t] * kap_R
  # Energy content of one egg, E_egg (J/egg)
  E_egg <- 0.0019
  # Fecundity, F (eggs)
  eggs[t] <- gam[t]/ E_egg
  
  
  # Model output
  
  # Total physical length, Lw (cm)
  L[t] <- V[t]^(1/3)/del_M
  # Total physical dry weight, Wdw (g) -- Excluding shell
  Wdw[t] <- V[t] * d_V + ((E[t] + ER[t]) * rho_E)
  # Total physical wet weight, Www (g)
  Www[t] <- Wdw[t] / d_V
  # Soma dry weigth, Wsdw (g)
  Wsdw[t] <- V[t] * d_V + E[t] * rho_E
  # Gonad dry weight (g)
  Wgdw[t] <- gam[t] * rho_E 
  # GSI (-)
  GSI[t] <- Wgdw[t]/(Wsdw[t])
  
  ## Step-forward variables (State variables)
  E[t+1] <- E[t] + dE.dt[t]
  V[t+1] <- V[t] + dV.dt[t]
  
  # Reproductive buffer (J) - it empties every 365 days
  ER[t+1] <- ifelse(time[t] %% 8760 != 0, ER[t] + dER.dt[t], 0)
  
  # Gametes (J) - it empties every 365 days
  gam[t+1] <- ifelse(time[t] %% 8760 != 0, gam[t] + dgam.dt[t], 0)
  
  # Troubleshooting  
  print(time[t])
}
## END OF MODEL LOOP ##

  plot(GSI, type='l')
  max(GSI[1:8760])
  plot(L, type='l')
  max(L)
  
  plot(Wgdw, type='l')
  plot(L[1:8760], Wgdw[1:8760], type='l')
  max(Wgdw[1:8760])

    
# Diagnostic plots --------------------------------------------------------------------

# Energy flows
plot(pA[1:1000], type='l')
lines(pC, col='red')
lines(pM, col='green')
lines(pR, col='yellow')
lines(pJ, col='orange')
