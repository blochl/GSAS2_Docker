# A container setup for running GSASII

## Purpose

[GSASII](https://subversion.xray.aps.anl.gov/trac/pyGSAS) is an open source
Python project that addresses all types of crystallographic studies, from
simple materials through macromolecules, using both powder and single-crystal
diffraction and with both X-ray and neutron probes.

Setting up GSASII can be troublesome, and results may differ in different
installation environments. A [Docker](https://www.docker.com) containerization
streamlines the installation process and makes sure that the installation
environment is uniform regardless of the local environment.

## Running

Simply run:

`./g2run.sh`

...Ideally from the directory in which you would like to work on the data.

That's it!

On the first run it will take some time, as the image will need to be
downloaded and configured for the system. Subsequent runs will start very fast.

## Configuring for the first run

1. Insatll Docker (if not installed).
2. Configure Docker as needed (*e.g.* images' location...)
3. Start the Docker daemon, and make it start automatically on subsequent runs:
    ```
    sudo systemctl start docker
    sudo systemctl enable docker
    ```
4. Add the intended user to the `docker` group:
    ```
    sudo usermod -a -G docker username
    ```
    (replace `username` with your actual user name.)
5. Log out, and log back in.

## Building the entire image yourself

If you would like to build the entire image yourself, you can modify the file
**Dockerfile.all** as needed, and start the build by running `buildall.sh`.
This process will take 20-25 minutes.

## Licensing

Distributed under GPLv2.
