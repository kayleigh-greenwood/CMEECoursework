# Kayleigh's CMEE MSc Project

## Title
This README file contains details about how to run the code from this project.

INSTRUCTIONS: run 'xyz' line to collate scripts and run project (after downloading the folders from the dropbox into a folder named "data" inside the "Project" folder. )
AUTHOR: Kayleigh Greenwood

## Languages
R version 3.6.3

## Dependencies/packages

### R: Wrangling
rjson (importing .json files)
stringr (string manipulation)
tidyr (pivoting dataframes)
readr (importing csv files)
readxl (importing xlsx files)
dplyr (grouping and summarising data)
tibble (converting rownames to a column)
countrycode (converting country codes to country names)
dplyr (left joining tables)

### R: Data Analysis & Modelling
plotrix (calculating standard error)
stats (linear models)

### R: Plotting
graphics (boxplot)
grDevices (creating pdfs)
rnaturalearth (plotting world map)
ggplot2 (plotting)

### Latex: Formatting
setspace (setting spacing)
fullpage (using headers and footers)
helvet (chosen font)
titlesec (title formatting)
lineno (add line numbers)
natbib (enhanced referencing)
geometry (sets margins)
hyperref (for in-text links)
caption (customising captions)
xcolor (link colour options)

### Latex: Graphics
graphicx (enhanced graphics)
float (accurate placement of figures and tables)

## Coding Scripts
***

### Data Wrangling

    WrangleBiodiversityData.R

**Summary:**  Wrangles the biodiversity data and matches area codes to countries <br />
**Input:** RawBiodiversityData.rds and RawAreaCodes.json <br />
**Output:** WrangledBiodiversityData.RDS <br />

    WrangleClimateData.R

**Summary:**  Wrangles the climate change data <br />
**Input:** all 230 files in the RawClimateData folder <br />
**Output:** WrangledClimateData.RDS <br />

    WrangleLandUseData.R

**Summary:**  Wrangles the land use data <br />
**Input:** RawLandUseData.csv <br />
**Output:** WrangledLandUseData.RDS <br />

    WranglePollutionData.R

**Summary:**  Wrangles the greenhouse gases data <br />
**Input:** RawPollutionData.csv <br />
**Output:** WrangledPollutionData.RDS <br />

    WrangleInvasiveSpeciesData.R

**Summary:**  Wrangles the invasive species data <br />
**Input:** RawInvasiveSpeciesData.xlsx <br />
**Output:** WrangledInvasiveSpeciesData.RDS <br />


### Modelling

    ClimateModel.R

**Summary:**  Models and plots the relationship between temperature and biodiversity <br />
**Input:** WrangledClimateData.RDS and WrangledBiodiversityData.RDS <br />
**Output:** ClimateSensitivityMap.pdf and ClimateSensitivityBoxplot.pdf <br />

    LandUseModel.R

**Summary:**  Models and plots the relationship between built land area and biodiversity <br />
**Input:** WrangledBiodiversityData.RDS and WrangledLandUseData.RDS <br />
**Output:** LandUseSensitivityMap.pdf and LandUseSensitivityBoxplot.pdf <br />

    PollutionModel.R

**Summary:**  Models and plots the relationship between greenhouse gases and biodiversity <br />
**Input:** WrangledPollutionData.RDS and WrangledBiodiversityData.RDS <br />
**Output:** PollutionSensitivityMap.pdf and PollutionSensitivityBoxplot.pdf <br />


    InvasiveSpecies.R

**Summary:**  Models and plots the relationship between invasive species and biodiversity <br />
**Input:** WrangledInvasiveSpeciesData.RDS and WrangledBiodiversityData.RDS <br />
**Output:** InvasiveSpeciesSensitivityMap.pdf and InvasiveSpeciesSensitivityBoxplot.pdf <br />

### Writeup

    Writeup.tex

**Summary:** Source code for write up PDF <br />

    Writeup.bib

**Summary:** Contains bibliography for write up  <br />

    CompileLatex.sh

**Summary:** Compiles Latex code and removes unnecessary files <br />
**Output:** Writeup.pdf <br />
