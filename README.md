
# Install docker

https://www.docker.com/products/docker-desktop

# Clone this the repository in a working folder on your computer

```
git clone https://github.com/cfmitrea/docker-tutorial.git
cd docker_tutorial

```

# Prepare input data

```
curl -O https://bitbucket.org/snakemake/snakemake-tutorial/get/v5.2.3.tar.bz2
tar -xf v5.2.3.tar.bz2 --strip 1  --exclude='*.md'  
```


# Build the image
```
docker build --rm -t samtools .       
```
- `--rm` removes intermediate steps
- `-t` tags the image - e.g. samtools
-  `.` look for the file Dockerfile in the current directory 


# Run the image:

```
docker run -v "$(pwd)"/data:/data/ -e "INPUT_FILE=A" --rm samtools:latest bash /opt/run.sh
```

 - `-v` mounts the folder data in the working directory into folder ``/data`` inside the docker container. The changes from within the container will be available after the container stops. 
 - `-e` set environment variable to be used inside the container  - here we use the env. variable to pass the sample name. Alternative: change the bash script to use command line arguments. 
 - `--rm` removes the container instance after it finishes. Alternative: use ``--name`` for container identification and remove the container using ``docker rm -v <name>`` after completion

This will start and run the container, running the run.sh script on the container.
It will create the mapped_reads folder on the container and the A.bam file in that folder. A BAM (Binary Alignment/Map) file is the compressed, binary version of a SAM (Sequence Alignment Map) file, used to store nucleotide sequence alignments against a reference genome.

# Debugging / interactive mode


```
docker run -v "$(pwd)"/data:/data/ -v "$(pwd)"/run.sh:/opt/run.sh -e "INPUT_FILE=A" --rm -it samtools:latest /bin/bash
```

 - `-it` enable interacitve mode - in combination with the command /bin/bash starts the bash terminal and waits for commands inside the container
 - `-v $(pwd)/run.sh:/opt/run.sh` mounts the file run.sh from working directory to the file inside the container, such that the changes in the script are available within the container without the need to rebuild the image.

This will start a terminal on the container.       
You can now run commands on the container.     
For instance, here is a command to see the first 10 lines of the result of the read mapping in the text version (.sam) of the binary file (.bam) for reads that aligned (4th column is not 0, that is the POS field, which represents the 1-based leftmost mapping position of the read on the reference sequence).

```
samtools view -h mapped_reads/A.bam | awk '$4!=0' | head
```

Use `exit` to leave and stop the container.
