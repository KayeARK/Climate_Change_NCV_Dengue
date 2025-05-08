# Climate_Change_NCV_Dengue
This code includes data and generates figures for "The effect of natural climate variability on future suitability for vector-borne disease: a mathematical modelling study" by AR Kaye, L Sun, WS Hart, JW Hurrell, MJ Tildesley and RN Thompson 2025

This repository has a "Data" and "Figures" file.

DATA

Climate and population data are too large for this repository and so need to be downloaded separately.

Climate data: Danabasoglu G, Lamarque J -F., Bacmeister J, et al. The Community Earth System Model Version 2 (CESM2). J Adv Model Earth Syst 2020; 12: e2019MS001916


FIGURES

Running a file named FigureXScript generates Figure X using data within the repository. Data that the model generates can be produced by running the scripts found within the FigureX file.

Note that the code to generate Figure 11 and 12 is not included in this repository. This is because a lot of suitability data is generated which would make the file size a lot larger. You can generate these figures from within the Figure 1 and 2 files. You simply need to change the value of the "decay" parameter found in M.m (within Figure1/EcologicalNicheGeneration/) to either 1/2 or 2.
