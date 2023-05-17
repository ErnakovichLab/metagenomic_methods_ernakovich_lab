#!/bin/bash

# Bash script for creating sickle commands
# create_cutadapt_commands.sh

# Define variables; FILL THIS PART IN
TN5_SEQ=CTGTCTCTTATACACATCT # transposase sequence
TN5_RC=AGATGTGTATAAGAGACAG # reverse complement of transposase sequence
TN5_SHORT=CTGTCTCTTATA # only 12 bp
TN5_RC_SHORT=AGATGTGTAT # only 12 bp
UNIV_ADAPT=AGATCGGAAGAGC
UNIV_ADAPT_RC=GCTCTTCCGATCT
PROJ_DIR=~/test_metaG
STAGE_DIR=$PROJ_DIR/00_cleaned_data
COMMAND_DIR=$PROJ_DIR/00_cleaned_data/01_cutadapt_transposase_commands # location to place the command files
DATA_DIR=/mnt/lz01/ernakovich/btc1042/AO-MetaG/reads # location of the input files
OUTPUT_DIR=$STAGE_DIR/01_qual_trim_transposase # location to put trimmed fastq files
CORES=4 # number of cores for cutadapt to use


# Move into datafile
cd $DATA_DIR

# make an file to put the command files in
mkdir -p $COMMAND_DIR

# make a directory to put the output in
mkdir -p $OUTPUT_DIR

# make commands and write them to a file
for i in $(ls *.fastq.gz)
do
    
    ## Arrange the variables
    prefix=${i%_R*.*}
    infile1="$DATA_DIR"/"$prefix"_R1 # note: must do this b/c sloppy 001 in filenames
    infile2="$DATA_DIR"/"$prefix"_R2 # note: ditto ^
    outfile1="$prefix"_R1_trans_trim.fastq.gz
    outfile2="$prefix"_R2_trans_trim.fastq.gz
    command_file_name=$COMMAND_DIR/"$prefix"_cutadapt_command.sbatch
    logfile_name=$COMMAND_DIR/"$prefix"_cutadapt.log
    
    ## Writing the batch script (note: formatting without indentation here is imporant)

cat << EOF > $command_file_name    
#!/bin/bash

# cd into the output directory
cd $OUTPUT_DIR 

# run the cutadapt command
# NOTE: to use multiqc with output logs, make sure cutadapt command ends with filename
# quality = 20, min length = 50, nextseq-trim = 20 (for polyGs)
cutadapt -a $TN5_SEQ -a $TN5_RC -A $TN5_SEQ -A $TN5_RC \
-n 2 -a $UNIV_ADAPT -a $UNIV_ADAPT_RC -A $UNIV_ADAPT -A $UNIV_ADAPT_RC \
-m 50 -q 20 --nextseq-trim=20 \
-j $CORES -o $outfile1 -p $outfile2 $infile1*.fastq.gz $infile2*.fastq.gz > $logfile_name


# write an empty .end file into the command directory so user can keep track while program runs
touch $command_file_name.end
    
EOF

done

# Make a file that lists the location of the commands

cd $COMMAND_DIR
ls $PWD/*.sbatch > commands.txt
