## Temperature correction function ####

# Driving variables = tide_threshold, Tbody
# Pars = TA, TAH, TAL, TH, TL, met_dep

#author = cristianmonaco
############################################################################################################

TC_fun <- function(Tbody, tide_threshold, TA, TAH, TAL, TH, TL, met_dep){
  ifelse(tide_threshold == 1,
               exp(TA/ 293 - TA/ Tbody) *
                 (1 + exp(TAL/ 293 - TAL/ TL) + exp(TAH/ TH - TAH/ 293)) / (1 + exp(TAL/ Tbody - TAL/ TL) + exp(TAH/ TH - TAH/ Tbody)),
               met_dep * exp(TA/ 293 - TA/ Tbody) *
                 (1 + exp(TAL/ 293 - TAL/ TL) + exp(TAH/ TH - TAH/ 293)) / (1 + exp(TAL/ Tbody - TAL/ TL) + exp(TAH/ TH - TAH/ Tbody)))
  
}