# Contextual influence on depression

This repository contains data, description scripts and analysis scripts for the publication
>__Contextual influence of reinforcement learning performance of depression: evidence for a negativity bias__   
Vandendriessche, Henri, Amel Demmou, Sophie Bavard, Julien Yadak, Cédric Lemogne, Thomas Mauras, and Stefano Palminteri
https://doi.org/10.1017/S0033291722001593


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
* Learning phase
    * two sessions for each participants
    * files have the following naming pattern TestX_SessionX.mat
    
    * COLUMN 1: subject number (2 3 4 6 7 8 9 10 11 14 15 16 18 20	24 26 28 30	31 33 34 35	36 37 38 39	40 41 42 43	44 45 46 47	48 49 50 51	52 53 54 55	60 61 63 64	65 66 67 68	69 70 71 72	73 75)
    * COLUMN 2: session number (1-2)
        * 1: Session 1
        * 2: Session 2
    * COLUMN 3: trial number (1:100)
    * COLUMN 4: condition number (1-2)
        * condition 1: poor context
        * condition 2: rich context
    * COLUMN 5: choice left/right (selection of the stimuli on the left or right)
        * -1: left
        * 1: right
    * COLUMN 6: choice (0 bad, 1 good)
        * 0: uncorrect
        * 1: correct
    * COLUMN 7: response time (ms)
    * COLUMN 8: outcome (0 for -1 and 1 for 1)
        * 0: negative outcome (0pts)
        * 1: positive outcome (1pts)
    * COLUMN 9: outcome observation time (ms)
    * COLUMN 10: checktime (timestamp of the stimuli onset)
    * COLUMN 11: checktime2 (timestamp of the outcome onset)

* Transfer phase
    * COLUMN 1 : subject number (2 3 4 6 7 8 9 10 11 14 15 16 18 20	24 26 28 30	31 33 34 35	36 37 38 39	40 41 42 43	44 45 46 47	48 49 50 51	52 53 54 55	60 61 63 64	65 66 67 68	69 70 71 72	73 75)
    * COLUMN 2 : trial number (1:112)
    * COLUMN 3 : symbol left (1:8)
    * COLUMN 4 : symbol right (1:8)
    * COLUMN 5 : time (timestamp on the onset of the symbols)
    * COLUMN 6 : choice
        * -1: left
        * 1: right
    * COLUMN 7 : response time (ms) 
