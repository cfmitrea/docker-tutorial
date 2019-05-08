
# Prepare input data

```
$ wget https://bitbucket.org/snakemake/snakemake-tutorial/get/v5.2.3.tar.bz2
$ tar -xf v5.2.3.tar.bz2 --strip 1  --exclude='*.md'  
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

$ docker run -v $(pwd)/data:/data/ -e "INPUT_FILE=A" --rm samtools:latest bash /opt/run.sh
```

 - `-v` mounts the folder data in the working directory into folder ``/data`` inside the docker container. The changes from within the container will be available after the container stops. 
 - `-e` set environment variable to be used inside the container  - here we use the env. variable to pass the sample name. Alternative: change the bash script to use command line arguments. 
 - `--rm` removes the container instance after it finishes. Alternative: use ``--name`` for container identification and remove the container using ``docker rm -v <name>`` after completion

# Debugging / interactive mode


```
$ docker run -v $(pwd)/data:/data/ -v $(pwd)/run.sh:/opt/run.sh -e "INPUT_FILE=A" --rm -it samtools:latest /bin/bash
```

 - `-it` enable interacitve mode - in combination with the command /bin/bash starts the bash terminal and waits for commands inside the container
 - `-v $(pwd)/run.sh:/opt/run.sh` mounts the file run.sh from working directory to the file inside the container, such that the changes in the script are available within the container without the need to rebuild the image. 
