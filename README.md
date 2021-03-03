# README #

### Repository Description ###

This repository contains code of the Multiple Sampling (MS) scheme for contructing stable Metabolic Brain Networks. Paper will soon be available.

### Setup ###

The toolbox runs on Matlab. But some plots are made in python.

* Matlab setup:
clone/download this repository.

* Python setup (using miniconda/anaconda):
1) If you do not have miniconda/anaconda installed, go to https://docs.conda.io/en/latest/miniconda.html and download it.

2) Open a terminal and type the following:

> conda create -n mbn_env python=3.8 -y

> source activate mbn_env

> conda install -c anaconda seaborn -y; conda install -c conda-forge matplotlib -y; conda install -c anaconda pandas -y; conda install -c anaconda click -y; conda install -c anaconda basemap -y; conda install -c anaconda scikit-image -y; conda install -c conda-forge nibabel -y; conda install -c anaconda mayavi -y;	

3) open new terminal and type (in linux machines)
> source activate mbn_env

4) Finally, from the opened terminal open matlab.

5) In Matlab, execute: 'run_example_human.m' or 'run_example_rat.m' to get an idea of how to use your own data.

### Methods ###

Check our paper for the details.

### Credits ###

We use many matlab packages in our implementation, including:
- https://sites.google.com/site/bctnet/ 
- https://github.com/paul-kassebaum-mathworks/circularGraph
- https://github.com/sccn/PACT/blob/master/bonf_holm.m
- https://github.com/rodyo/FEX-settingsdlg
- https://www.mathworks.com/matlabcentral/fileexchange/71638-text-wait-progress-bar
- Dominic Siedhoff (2020). ADASYN (improves class balance, extension of SMOTE) (https://www.mathworks.com/matlabcentral/fileexchange/50541-adasyn-improves-class-balance-extension-of-smote), MATLAB Central File Exchange. Retrieved October 19, 2020.

### Contato ###
guischu09@gmail.com - Guilherme Schu


