# Reproducible Computing Setup

## Project Overview

This project demonstrates a reproducible computing setup using Python with conda/mamba, R with renv, and Docker. The goal is to ensure that another user can clone the repository, recreate the required software environments from the provided environment files, and run the analysis scripts without needing any additional information about the original computer setup.

## Project Structure

```text
repro-demo/
├── README.md
├── AI_USAGE.md
├── conda-version/
│   ├── analyze.py
│   ├── environment.yml
│   └── Dockerfile
├── renv-version/
│   ├── renv.R
│   └── renv.lock
└── uv-version/
│   ├── pyproject.toml
│   └── uv.lock
```

The `conda-version` directory contains the Python environment and analysis used for the conda/mamba workflow, as well as a container reproducing that environment. The Docker container reproduces the Python conda environment in an isolated Linux environment. The `renv-version` directory contains the R environment and analysis used for the `renv` workflow. The `uv-version` directory contains the python environment by uv.

## Prerequisites

Before running this project, make sure the following software is installed:

* Git
* Miniforge with `conda` and `mamba`
* R
* `renv` R package
* Docker Desktop

You can verify the main command-line tools with:

```bash
git --version
conda --version
mamba --version
docker --version
```

In R, verify that `renv` is installed with:

```r
library(renv)
packageVersion("renv")
```

## Clone the Repository

Clone the GitHub repository:

```bash
git clone https://github.com/sofiafeiranz/hds-practical.git
```

Move into the project directory:

```bash
cd hds-practical/repro-demo
```

## Python Environment with Conda/Mamba

The Python environment is defined in:

```text
conda-version/environment.yml
```

Move into the conda project directory:

```bash
cd conda-version
```

Create the environment from `environment.yml`:

```bash
mamba env create -f environment.yml
```

Activate the environment:

```bash
conda activate repro-demo
```

Run the Python analysis:

```bash
python analyze.py
```

The script creates a small patient dataset and produces summary statistics for the `age` variable.

To leave the environment when finished:

```bash
conda deactivate
```

## Testing Python Environment Reproducibility

The environment can be completely removed and recreated using only `environment.yml`.

Remove the existing environment:

```bash
conda deactivate
mamba env remove -n repro-demo -y
```

Recreate it:

```bash
mamba env create -f environment.yml
conda activate repro-demo
```

Run the analysis again:

```bash
python analyze.py
```

The output should be the same as before the environment was deleted.

## R Environment with renv

The R environment is defined by:

```text
renv-version/renv.lock
```

From the `repro-demo` directory, move into the R project:

```bash
cd renv-version
```

Start R from this directory and restore the packages recorded in `renv.lock`:

```r
renv::restore()
```

Then run the saved R analysis:

```r
source("analyze.R")
```

The analysis creates the toy patient dataset and summarizes it using the R packages recorded in the reproducible environment.

## Testing R Environment Reproducibility

To test whether the R environment can be reproduced from the lockfile, run:

```r
renv::deactivate()
unlink("renv/library", recursive = TRUE)
renv::activate()
renv::restore()
```

Then rerun the analysis:

```r
source("analyze.R")
```

The script should produce the same result after the environment has been restored from `renv.lock`.

## Docker

The Docker configuration is located at:

```text
conda-version/Dockerfile
```

Docker provides additional isolation beyond the conda environment by reproducing the operating-system-level environment in addition to the Python packages.

Make sure Docker Desktop is running.

From the `repro-demo` directory, move into the conda directory:

```bash
cd conda-version
```

Build the Docker image:

```bash
docker build -t repro-demo .
```

Run the container:

```bash
docker run --rm repro-demo
```

The Docker container runs `analyze.py` inside the recreated conda environment. Its output should match the output produced by running:

```bash
python analyze.py
```

natively in the conda environment.

## Conda vs. renv vs. uv

Conda, uv, and renv can all be used to create reproducible computing environments, but they are designed for somewhat different workflows. Conda uses environment.yml to specify the Python version and packages, while uv uses pyproject.toml together with uv.lock to manage Python dependencies and recreate the environment with uv sync; renv uses renv.lock to record and restore the R packages required by a project. I found uv to be the simplest and fastest Python workflow because it automatically manages the virtual environment and lockfile, while conda gives more control over Python versions and non-Python software dependencies. For a Python-focused project I would likely prefer uv, for a project requiring broader software dependencies I would use conda, and for an R-focused project I would use renv because it integrates directly with the R project workflow.
## AI Assistance

Generative AI assistance used while completing this project is documented separately in:

```text
AI_USAGE.md
```

The file records the specific errors or questions discussed with AI, what the errors meant, suggested fixes, and how those fixes were verified before or after being applied.
