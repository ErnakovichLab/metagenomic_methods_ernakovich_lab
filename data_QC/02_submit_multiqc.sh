#!/bin/bash

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
#SBATCH --output="02_submit_multiqc_%j.output"

## Load the appropriate modules first.  Linuxbrew/colsa contains most
## programs, though some are contained within the anaconda/colsa
## module.  Refer to http://premise.sr.unh.edu for more info.


# Load modules/software
module purge # first remove any modules already loaded on core
module load anaconda/colsa
conda activate multiqc-1.10.1

# Make directories
PROJ_DIR=~/test_metaG # the directory that you're doing the project work in
STAGE_DIR=$PROJ_DIR/00_cleaned_data # The directory for the stage of the analysis, eg. cleaning, assembly, etc.
MULT_QC_DIR=$STAGE_DIR/multiqc_output

cd $STAGE_DIR

mkdir -p $MULT_QC_DIR


multiqc 00_qual_check -v -o $MULT_QC_DIR -ip -n 00_multiqc_report_pre_cleaning.html
