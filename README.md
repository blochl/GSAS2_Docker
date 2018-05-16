# A container setup for running GSAS-II

## Purpose

[GSAS-II](https://subversion.xray.aps.anl.gov/trac/pyGSAS) is an open source
Python project that addresses all types of crystallographic studies, from
simple materials through macromolecules, using both powder and single-crystal
diffraction and with both X-ray and neutron probes.

Setting up GSAS-II can be troublesome, and results may differ in different
installation environments. A [Docker](https://www.docker.com) containerization
streamlines the installation process and makes sure that the installation
environment is uniform regardless of the local environment.

## Running

Simply run:

`./g2run.sh`

...Ideally from the directory in which you would like to work on the data.

That's it!

* The very first run needs to be done from the directory that contains the
**Dockerfile**, and it will take some time, as the image will need to be
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
    sudo usermod -a -G docker <USERNAME>
    ```
    (replace `<USERNAME>` with the actual user name.)
5. Log out, and log back in.

## Building the entire image yourself

If you would like to build the entire image yourself, you can modify the file
**Dockerfile.all** as needed, and start the build by running `buildall.sh`.
This process will take 20-25 minutes.

## Troubleshooting

Sometimes closing the windows in the wrong order may leave the application
stuck. In this case you can stop the container by:
1. Finding out the container's ID: `docker ps`
2. Stopping it: `docker stop <CONTAINER ID>`

## Licensing

These scripts are distributed under the
[GPLv2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt) license. GSAS-II
is distributed under the licence that can be found
[here](https://subversion.xray.aps.anl.gov/pyGSAS/trunk/license2013.txt).
