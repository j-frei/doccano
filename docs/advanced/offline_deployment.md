# Doccano Offline Deployment

## Use Case 1: Docker Deployment
These offline deployment scripts are suited for deploying Doccano on an air gapped Ubuntu 18.04/20.04 virtual machine (VM 2) with no internet connectivity (such as in clinical environments).

The preparation requires another machine (VM 1) with internet access and `docker`/`docker-compose` preinstalled (with $USER in `docker` group) and running the same Ubuntu distribution as VM 2.  

The focus is primarily on the `docker-compose`-based production deployment.
The files mentioned in this document are located in the `tools/offline_deployment/` directory.

### Setup Steps

Run the following steps on VM 1:  
1. Clone this repository  
2. Run the scripts `offline_01_*.sh` in ascending order  
   Skip OR modify and run the script `offline_01_1-optional_use_https`  
   Do NOT run these scripts as `sudo`! The scripts will ask for sudo-permissions when it is needed.  

Now, move over to VM 2  

3. Copy the repository folder from VM 1 to VM 2  
4. Run the scripts `offline_02_*.sh` in ascending order  
   Do NOT run these scripts as `sudo`! The scripts will ask for sudo-permissions when it is needed.  
5. Make minor changes on `docker-compose.prod.yml` to change the admin credentials  
6. Run `docker-compose -f docker-compose.prod.yml up` in the repository root directory or use the script `offline_03_*.sh`  

### Remarks

The setup was tested on Ubuntu 18.04 machines.

## Use Case 2: PIP Deployment
Similar to Use Case 1, but without `docker`/`docker-compose`. Instead the PIP deployment method is used. This can be advantageous in a scenario where `root`/`sudo` access is not possible.

The preparation requires another machine (VM 1) with internet access with `pip` preinstalled and running the same distribution as VM 2.  

The files mentioned in this document are located in the `tools/offline_deployment/` directory and its `pip` subdirectory.

### Setup Steps

Run the following steps on VM 1:  
1. Clone this repository  
2. Run the script `downloadAndPatch.sh`  
   Eventually the Doccano PIP package `doccano-*.tar.gz` in `pip/packages` is patched for offline usage.  
   The original PIP package is stored as `pip/doccano-*.tar.gz.bak`  


Now, move over to VM 2  

3. Copy the repository folder from VM 1 to VM 2  
4. Install the patched `doccano-*.tar.gz` package with the command `python3 -m pip install ./path/to/pip/packages/doccano-*.tar.gz`  
   Make sure to install all required, additional PIP packages.
