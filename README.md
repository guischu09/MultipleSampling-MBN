# README #

### Repository Description ###

This repository contains code of the Multiple Sampling (MS) scheme for contructing stable Metabolic Brain Networks proposed at: https://doi.org/10.1101/2021.03.16.435674

### Setup ###

The toolbox runs on Matlab. But some plots are made in python.

* Matlab setup:
clone/download this repository.

* Python setup (using miniconda/anaconda):
1) If you do not have miniconda/anaconda installed, go to https://docs.conda.io/en/latest/miniconda.html and download it.

2) Open a terminal and type the following:

> conda create -n mbn_env -c conda-forge python=3.7 seaborn matplotlib pandas click basemap scikit-image nb_conda nibabel vtk netcdf4 mayavi

3) open new terminal and type (in linux machines)
> conda activate mbn_env

4) Finally, from the opened terminal open matlab.

5) In Matlab, execute: "main.m" to get an idea of how to use your own data.

### Inputs ###
Check the Input directory for more details and follow the exact structure in the sample input files to generate your own results.

### Methods ###

Check our paper for the details: Stable brain PET metabolic networks using a multiple sampling scheme - https://doi.org/10.1101/2021.03.16.435674

### Credits ###

We use many matlab packages in our implementation, including:
- https://sites.google.com/site/bctnet/ 
- https://github.com/paul-kassebaum-mathworks/circularGraph
- https://github.com/sccn/PACT/blob/master/bonf_holm.m
- https://github.com/rodyo/FEX-settingsdlg
- https://www.mathworks.com/matlabcentral/fileexchange/71638-text-wait-progress-bar
- Dominic Siedhoff (2020). ADASYN (improves class balance, extension of SMOTE) (https://www.mathworks.com/matlabcentral/fileexchange/50541-adasyn-improves-class-balance-extension-of-smote), MATLAB Central File Exchange. Retrieved October 19, 2020.
- https://github.com/makto-toruk/FC_geodesic

### Contato ###
guischu09@gmail.com - Guilherme Schu


