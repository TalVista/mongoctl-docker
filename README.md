# Mongoctl Docker Image

Mongoctl is a great tool for accessing many of the features of MongoDB while being able to use Mongo URLs. This docker image allows several capabilties:

* You do not need to install MongoDB, mongo shell, or mongoctl (with Python support) on your system
* You can access SSL and non-SSL connections using mongoctl

For convenience, several bash script's are included in the image that allow you to use mongoctl more easily from the command line. Copy the scripts to a location on your path.

This command will copy the scripts off of the docker image into your current directory. You can then move the scripts to a location on your path.

```
docker run --rm --entrypoint bash unitive/mongoctl client-install.sh | tar -xf -
```

# Scripts

## `mongoctl`

The `mongoctl` script is the basic script for running `mongoctl`. Just run the script as if you were running `mongoctl`.

## `mongo-dump`

The `mongo-dump` script will run `mongoctl` from the docker image with paths setup properly for doing a dump of a mongo database.  

```
Usage: mongo-dump TARGET OUTDIR
    TARGET: a Mongo URI
    OUTDIR: the dump output directory
```

## `mongo-restore`

The `mongo-restore` script will run `mongoctl` from the docker image with paths setup properly for doing a restore of a mongo database.

```
Usage: mongo-restore DESTINATION SOURCE
    DESTINATION:  a Mongo URI
    SOURCE:       the restore source directory
    options:      see mongoctl restore for options
```

# Shell Access

You can access the shell of the container using:

```
docker run --interactive --tty --rm \
  --volume "${HOME}/.mongoctl:/root/.mongoctl" \
  --entrypoint bash unitive/mongoctl
```

or more commonly

```
docker run -it --rm -v "${HOME}/.mongoctl:/root/.mongoctl" \
  --entrypoint bash unitive/mongoctl
```
