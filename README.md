**Dynamic Energy Budget (DEB) model application - Mussel Zonation and Reproductive Potential**

Scripts to run DEB models for Perna perna and Mytilus galloprovincialis.
The file `DEB_model_app_master.R` operates the model based on environemental data (contained in the file `env.Rda`) and user defined conditions specified in the file `user_input.R`.
In the file `user_input.R`, the user can specify which species, site, and shore level to use. The user can also specify the number of years that the model should run.
The files `DEB_pars_Mytilus.R` and `DEB_pars_Perna.R` provide the parameter values that orchestrate the model.
The file `TC_fun.R` containes the equations to calculate the thermal sensitivity of Perna and Mytilus both under aquatic and aerial conditions.

DEB theory is fully explained in the book by S.A.L.M. Kooijman, "Dynamic Energy Budget Theory For Metabolic Organization", 2010, 3rd edition, Cambridge. 

This version of the model is used in the manuscript in prep "Invasive species reproductive advantage: observations and predictions in a heterogeneous world" by Cristián J. Monaco and Christopher D. McQuaid (Rhodes University, South Africa).
