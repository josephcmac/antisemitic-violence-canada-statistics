# Antisemitic Violence in Canada: Statistics

Modeling Antisemitic Violence in Canada Using Poisson Regression

## Overview

This project models antisemitic violence incidents in Canada using Poisson regression techniques. By examining historical data on reported incidents, the analysis seeks to identify trends, potential predictors, and assess the goodness-of-fit of various Poisson models.

The dataset is [B'nai Brith Canada](https://www.bnaibrith.ca/antisemitic-incidents/) 

## Requirements

- **R** (version 3.6 or higher recommended)
- Required R packages (if any) should be installed before running the scripts. For example:
  ```r
  install.packages(c("tidyverse", "ggplot2", "dplyr")) # example packages
  ```
- A local folder named `pictures` must exist in the project directory to store generated output images.

## Getting Started

1. **Clone this repository**:
   ```bash
   git clone https://github.com/your-username/antisemitic-violence-canada-statistics.git
   cd antisemitic-violence-canada-statistics
   ```

2. **Create a `pictures` folder** (if it does not already exist):
   ```bash
   mkdir pictures
   ```

3. **Install R dependencies** (within R):
   ```r
   # Example:
   install.packages(c("tidyverse", "ggplot2", "dplyr"))
   ```
   (Include or update this list as needed.)

4. **Run the script** to generate images of all incidents:
   ```bash
   Rscript incidents_all.R
   ```
   - This script will produce visualizations of antisemitic violence incidents and save them into the `pictures` folder.

## Project Structure

```
antisemitic-violence-canada-statistics/
├── data/                   # Contains the dataset(s) (if included)
├── pictures/               # Folder to store generated plots and images
├── incidents_all.R         # Main script to generate all incident plots
├── README.md               # Project documentation
└── ... (other files, scripts, or folders)
```

## Methodology (Optional Section)

If helpful, add details on how the Poisson regression modeling is conducted:

1. **Data Cleaning and Preparation**  
   Briefly describe how data was sourced, cleaned, and organized.

2. **Statistical Model**  
   - State why Poisson regression is suitable for this type of count data.
   - Mention any alternative models (e.g., Negative Binomial) if used for comparison.

3. **Visualization**  
   - Summarize how plots/figures are generated and what insights they can offer.

## Contributing

Contributions to enhance the data analysis, add new features, or improve the documentation are welcome. Please follow these steps:

1. [Fork the repository](https://github.com/your-username/antisemitic-violence-canada-statistics/fork).
2. Create a new branch:
   ```bash
   git checkout -b feature/new-feature
   ```
3. Commit changes:
   ```bash
   git commit -m "Add new feature"
   ```
4. Push to the branch:
   ```bash
   git push origin feature/new-feature
   ```
5. Open a Pull Request describing your changes.

## Disclaimer

- The analyses presented here are for informational and educational purposes only.  

## Contact

- **Author**: [José Manuel Rodríguez Caballero](https://github.com/josephcmac)

