# Climate_Change_NCV_Ae_Aegypti
This code includes data and generates figures for "The impact of climate change and natural climate variability on the global distribution of Aedes Aegypti" by AR Kaye, U Obolksi, L Sun, JW Hurrell, MJ Tildesley and RN Thompson 2023

This repository has a "Data" and "Figures" file.

DATA

Climate data generated by the CESM is found within the file ClimateData, this consists of temperature and precipitation values for 2020, 2060 and 2100 globally for each of the 100 different climate projections. This data is passed through the model to generate a global suitability map for each climate projection (found in SuitabilityData202020602100 and generated by MComputationEachSim.m). Statistics about this data are then found in SuitabilityDataStatistics202020602100 (generated by ComputationofMeanofM.m)

FIGURES

Running a file named FigureXScript generates Figure X using data within the repository. Data that the model generates can be produced by running the scripts found within the FigureX file.

Note that the code to generate Figure 11 and 12 is not included in this repository. This is because a lot of suitability data is generated which would make the file size a lot larger. You can generate these figures from within the Figure 1 and 2 files. You simply need to change the value of the "decay" parameter found in M.m (within Figure1/EcologicalNicheGeneration/) to either 1/2 or 2.