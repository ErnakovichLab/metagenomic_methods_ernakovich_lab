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
#SBATCH --cpus-per-task=8

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
#SBATCH --job-name="RunningFastqc"
#SBATCH --output="04_Second_fastqc-%A_%a.output" # %A = jobid; %a = array index

## If we're running an array job (multiple jobs launched simultaneously)
#SBATCH --array=1-2 # Job array index

## Load the appropriate modules first.  Linuxbrew/colsa contains most
## programs, though some are contained within the anaconda/colsa
## module.  Refer to http://premise.sr.unh.edu for more info.
module purge
#module load anaconda/colsa
#conda activate metagenomic_methods_ernakovich_lab_v0.1
module load linuxbrew/colsa

## Let the user know what sample you're working on:
echo "parsing sample: SRR09833"${SLURM_ARRAY_TASK_ID}

# Setup Variables
PROJ_DIR=~/test_metaG
STAGE_DIR=$PROJ_DIR/00_cleaned_data
COMMAND_DIR=$STAGE_DIR/02_fastqc_commands
## Get command file from commands.txt; #CHANGE ME
COMMAND_FILE_PATH=$COMMAND_DIR/commands.txt

file=`head -n $SLURM_ARRAY_TASK_ID $COMMAND_FILE_PATH | tail -n 1`

## Instruct your program to make use of the number of desired threads.
## As your job will be allocated an entire node, this should normally
## be 24.

# Run the shell script
bash $file
