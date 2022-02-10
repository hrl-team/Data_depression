# Contextual influence on depression

This repository contains data, description scripts and analysis scripts for the publication
>__Contextual influence of reinforcement learning performance of depression: evidence for a negativity bias__   
Vandendriessche, Henri, Amel Demmou, Sophie Bavard, Julien Yadak, Cédric Lemogne, Thomas Mauras, and Stefano Palminteri
https://doi.org/10.31234/osf.io/s8bf7


## Organisation of the repository

This repo is composed of:
* Anonymized data (in format .mat) of the participants in the data_expe directory.
* An R script (data_depression.Rmd) to display the main results of the paper.
* A simulation script (RichPoor_Simulations_GitHub.m in Matlab) with plotting functions in the simulations directory.

## General results
Run the data_depression.Rmd to get the main results and figures of the paper.
Run the RichPoor_Simulations_Github.m to get the simulated learning curves and learning rates.

## Data
All behavioral data are stored in the raw matrix *data.mat*. The columns are ordered as follows:  
Learning phase
    two sessions for each participants
    files have the following naming pattern TestX_SessionX.mat
* COLUMN 1 : subject number
* COLUMN 2 : session number (1-2)
    * 1
* COLUMN 3 : trial number
* COLUMN 4 : condition number (1-2)
* COLUMN 5 : left/right
* COLUMN 6 : choice (0 bad, 1 good)
* COLUMN 7 : reaction time action
* COLUMN 8 : outcome (0 for -1 and 1 for 1)
