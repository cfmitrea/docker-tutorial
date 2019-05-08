# use a predefined image with conda 
FROM biocontainers/biocontainers:latest

# install the required tools, use exact versions for reproducibility
RUN conda install samtools=1.9 bwa=0.7.17

# add the bash script
ADD run.sh /opt/run.sh

WORKDIR /data/

# here we could provide the desired default command
CMD ["samtools"]
