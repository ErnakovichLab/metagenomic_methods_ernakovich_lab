#!/bin/bash
## This task probably doesn't need to be run as a slurm script, it's generally quite small computationally

## Note - Slurm script comments require two hash symbols (##).  A single
## hash symbol immediately followed by SBATCH indicates an SBATCH
## directive.  "##SBATCH" indicates the SBATCH command is commented
## out and is inactive.

## NTasks is not thread count, be sure to leave it set at 1
#SBATCH --ntasks=1

## If your program will be using less than 24 threads, or you
## require more than 24 threads, set cpus-per-task to the 
## desired threadcount.  Leave this commented out for the
## default 24 threads.
##SBATCH --cpus-per-task=2

## You will need to specify a minimum amount of memory in the
## following situaitons:
##   1. If you require more than 128GB of RAM, specify either:
##      a. "--mem=512000" for at least 512GB of RAM (6 possible nodes)
##      b. "--mem=1000000" for at least 1TB of RAM (2 possible nodes)
##   2. If you are running a job with less than 24 threads, you will
##      normally be given your thread count times 5.3GB in RAM.  So
##      a single thread would be given about 5GB of RAM.  If you
##      require more, please specify it as a "--mem=XXXX" option,
##      but avoid using all available RAM so others may share the node.
##SBATCH --mem=512000

## Normally jobs will restart automatically if the cluster experiences
## an unforeseen issue.  This may not be desired if you want to retain
## the work that's been performed by your script so far.   
## --no-requeue

## Normal Slurm options
## SBATCH -p shared
#SBATCH --job-name="Multiqc"
#SBATCH --output="05_second_submit_multiqc_%j.output"

## Load the appropriate modules first.  Linuxbrew/colsa contains most
## programs, though some are contained within the anaconda/colsa
## module.  Refer to http://premise.sr.unh.edu for more info.


# Load modules/software
module purge # first remove any modules already loaded on core
module load anaconda/colsa
conda activate metagenomic_methods_ernakovich_lab_v0.1

# Set up directories
PROJ_DIR=~/test_metaG
STAGE_DIR=$PROJ_DIR/00_cleaned_data
MULT_QC_DIR=$STAGE_DIR/multiqc_output
MULTIQC_CONFIG_YML=/mnt/lz01/ernakovich/heh1030/metagenomics_methods_ernakovich_lab/data_QC/multiqc_config.yaml

cd $STAGE_DIR

mkdir -p $MULT_QC_DIR


#multiqc 01_qual_check -o $MULT_QC_DIR -n 00_multiqc_report_pre_cleaning.html

multiqc 00_qual_check 01_cutadapt_transposase_commands 00_qual_check 02_qual_check -o $MULT_QC_DIR -c $MULTIQC_CONFIG_YML -n 03_multiqc_report_post_cleaning.html --interactive -f
