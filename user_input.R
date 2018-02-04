## User input ####

  # Script to define species, site, shore level, and climate change scenario
  # User can modify depending on desired model run

#author = cristianmonaco
############################################################################################################

# Define species ----------------------------------------------------------
# Perna (Perna perna), Mytilus (Mytilus galloprovincialis) #
species <- "Perna"        ## CHANGE DEPENDING OF SPECIES
species <- rep(species, nrow(env))

# Define site -------------------------------------------------------------
# BR (Brenton-on-sea), PT (Plettenberg Bay), KB (Keurboomstrand) #
site <- "BR"              ## CHANGE DEPENDING OF SITE
site <- rep(site, nrow(env))

# Define shore level ------------------------------------------------------
# Low, Mid, High #
level <- "Low"              ## CHANGE DEPENDING OF SHORE LEVEL
level <- rep(level, nrow(env))

# Climate change scenarios ------------------------------------------------
# current (0), RCP8.5_air (+3.5), RCP8.5_water (+2.21), RCP8.5_air_water (+3.5, +2.01)
ccs <- "RCP8.5_air_water"              ## CHANGE DEPENDING OF CLIMATE CHANGE SCENARIO
ccs <- rep(ccs, nrow(env))

# Number of years ran -----------------------------------------------------
n_years <- 10              ## CHANGE DEPENDING OF NUMBER OF YEARS OF MODEL RUN

