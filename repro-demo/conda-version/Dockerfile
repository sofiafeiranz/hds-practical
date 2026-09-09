FROM condaforge/miniforge3:latest
WORKDIR /workspace
COPY environment.yml .
RUN mamba env create -f environment.yml && mamba clean -afy
COPY analyze.py .
SHELL ["conda", "run", "-n", "repro-demo", "/bin/bash", "-c"]
CMD ["conda", "run", "--no-capture-output", "-n", "repro-demo", "python", "analyze.py"]
