### Intermittent control of mouse movements.

##### By Alberto Álvarez, Henrik Gollee, Jörg Müller and Roderick Murray-Smith
##### University of Glasgow. Schools of Engineering and Computing Science.
##### University of Bayreuth. Institute for Computer Science.

##### alberto.alvarez-martin@glasgow.ac.uk

---------------------------------------------------------------

This repository contains the Python notebooks, MATLAB scripts, and files
required to explore the data obtained from the optimisation process based
on intermittent control (IC) applied to a pointing task. This is the
supplementary material provided for the paper.

###### REQUIREMENTS

Python should be installed on your system. To install all the dependencies
you can create a new virtual environment, activate it and then use pip to
install everything. The following lines should work:

```shell
$ python -m venv venv              # This starts a virtual environment
$ source venv/bin/activate         # Activate the environment
$ pip install -r requirements.txt  # Install the dependencies
```

Then install the CRETools-0.1.0 package before running the notebook
```ic_point.ipynb``` as follows:

* Go to the directory called ```CRETools-0.1.0``` and build the package with:

```shell
python setup.py sdist
```

* In the same directory, use the following line to install it:

```
python setup.py install
```

The following external libraries are necessary to run the notebook:

* umap-learn (https://pypi.org/project/umap-learn/)

* numpy (https://numpy.org/)

* seaborn (https://seaborn.pydata.org/)

* pandas (https://pandas.pydata.org/)

* scipy (https://www.scipy.org/)

* universal-divergence (https://pypi.org/project/universal-divergence/)


MATLAB (The MathWorks, Inc.) needs to be installed in your system to run
the scripts in the matlab directory.

###### ic_point.ipynb (full parameter set)

This notebook runs several visualisations of the data and generates some
of the plots in the paper, when the full set of parameters is used for
optimisation purposes.

###### ic_point_min.ipynb (reduced parameter set)

This notebook provides visualisations of the data when the reduced
parameter set is used for optimisation. It also includes the figures
corresponding to the Uniform Manifold Approximation (UMAP) section of the
paper, performed on the reduced parameter set.

###### ic_point_cost.ipynb

This notebook provides a figure that compares the quality of fit between the
two optimisation datasets (full vs reduced) by looking at the cost function
values.

###### data_files directory

This directory contains all the files needed for the analysis on the
optimised parameters, all of them have the extension .mat and were
generated using MATLAB.

###### matlab directory

This directory contains files to generate the experimental and simulated
time-series and phase-planes for all participants and conditions. To
generate the figures, just call ic_point.m in MATLAB's command prompt.

---------------------------------------------------------------

##### REFERENCES

Müller, Jörg, Antti Oulasvirta, and Roderick Murray-Smith. "Control
theoretic models of pointing." ACM Transactions on Computer-Human
Interaction (TOCHI) 24, no. 4 (2017): 27.