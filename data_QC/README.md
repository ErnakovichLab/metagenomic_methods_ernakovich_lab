# Data Cleaning Workflow
Placeholder for information on the cleaning workflow

Current workflow:
 1. Assess initial quality with `fastqc`
  - run `./01a_create_fastqc_commands.sh` to create fastqc commands
  - run `sbatch 01_run_fastqc_commands.slurm` to run a batch job that runs each of the created commands on slurm
 2. Evaluate multiple sequence quality with `multiqc`
  - run	`02_submit_multiqc.sh` to create multiqc report. This is computationally small enough that it can generally be run on the login node with no issue 
 3. Use `cutadapt` to remove residual transposases from library creation, quality-filter the data (q=20, min length = 50), and remove NovaSeq PolyG's
  - run	`./03a_create_cutadapt_transposase_commands.sh` to create commands
  - run	`sbatch 03_run_cutadapt_commands.sh` to run a batch job that runs each of the created commands on slurm
 4. Assess cleaned sequence quality with `fastqc`
  - run `./04a_create_fastqc_commands.sh` to create fastqc commands
  - run `sbatch 04_run_fastqc_commands.slurm` to run a batch job that runs each of the created commands on slurm
 5. Evaluate multiple sequence quality with `multiqc`
  - run `05_submit_multiqc.sh` to create multiqc report. This is computationally small enough that it can generally be run on the login no$

