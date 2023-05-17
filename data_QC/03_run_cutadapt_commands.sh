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
#SBATCH --cpus-per-task=4 # because we specified 4 cpus per cutadapt run

## This will specify that all threads for each task are on the same node
#SBATCH -N 1

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
## SBATCH -p shared # for partition, leave blank
#SBATCH --job-name="Cutadapt"
#SBATCH --output="03_cutadapt-%A_%a.output" # %A = jobid; %a = array index

## If we're running an array job (multiple jobs launched simultaneously)
#SBATCH --array=1-2 # Job array index

## Load the appropriate modules first.  Linuxbrew/colsa contains most
## programs, though some are contained within the anaconda/colsa
## module.  Refer to http://premise.sr.unh.edu for more info.
module purge
module load anaconda/colsa
conda activate metagenomic_methods_ernakovich_lab_v0.1

## Get command file from commands.txt; #CHANGE ME
COMMAND_FILE_PATH=/mnt/lz01/ernakovich/heh1030/test_metaG/00_cleaned_data/01_cutadapt_transposase_commands/commands.txt

file=`head -n $SLURM_ARRAY_TASK_ID $COMMAND_FILE_PATH | tail -n 1`

## Let the user know what sample you're working on:
echo "Running sample"
echo $file

##  Task calculation ##
## You should run some tests so that you can fill in the xxx's below ##

# 1 task takes a maximum of 30 minutes to run
# In a walltime of 3 hours, a minimum of 9 jobs can be run on a single core
# I will start 1 batch of 9 tasks each (xxx jobs total in 2 hrs) to complete the 
# xxx total jobs


# Load modules/software
module purge # first remove any modules already loaded on core
module load anaconda/colsa
conda activate metagenomic_methods_ernakovich_lab_v0.1

# Run the shell script
bash $file

