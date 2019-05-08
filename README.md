
# Prepare input data

```
$ wget https://bitbucket.org/snakemake/snakemake-tutorial/get/v5.2.3.tar.bz2
$ tar -xf v5.2.3.tar.bz2 --strip 1  --exclude='*.md'  
```


# Build the image
```
docker build --rm -t samtools .       
```



# Run the image:

```

$ docker run -v $(pwd)/data:/data/ -e "INPUT_FILE=A" samtools:latest bash /opt/run.sh
```
