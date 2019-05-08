#!/bin/bash

#stop bash if a command fails or a variable is used but not initialized
set -euo pipefail

#optionally if we want to echo each command
set -x

# stop if the env variable is missing 
inputfile=${INPUT_FILE?"provide the sample name as the INPUT_FILE env variable"}

# create output folder if it does not exist
mkdir -p /data/mapped_reads

# run the desired command
bwa mem genome.fa /data/samples/${inputfile}.fastq | samtools view -Sb - > /data/mapped_reads/${inputfile}.bam
