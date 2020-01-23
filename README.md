# azure-f5-palo
Deploys a security stack where PaloAlto firewalls are internet-facing, and F5 BIG-IP's perform application services in a second tier. Uses marketplace (PAYG) images so that license keys or eval keys are not required, but production or long-term use cases can edit the templates as desired to use BYOL licenses and license keys.

## Architecture

## Instructions to deploy
To deploy via Powershell, download the file Deploy_via_Powershell.ps1 and run a command similar to the following:
`.\Deploy_via_PS.ps1 -adminUsername azureuser -adminPasswordOrKey MY-PASSWORD -dnsLabel SOME-UNIQUE-VALUE -resourceGroupName YOUR-RESOURCE-GROUP`

## High Availability
This set of templates will automatically configure HA via Azure Load Balancers.

Palo Alto deployment guide for HA is here: https://docs.paloaltonetworks.com/vm-series/9-0/vm-series-deployment/set-up-the-vm-series-firewall-on-azure/configure-activepassive-ha-for-vm-series-firewall-on-azure.html

## Notes
* This set of templates will deploy F5 BIG-IP and PaloAlto VM-Series images from marketplace images. This means you will be charged on a PAYG basis.
* To build templates for PaloAlto VMs, I have started with a sample from PaloAlto's examples [here](https://github.com/PaloAltoNetworks/azure/tree/master/vmseries-avset) and made some modifications to deploy 2 VMs with external and internal load balancers.
* To build templates for F5 VM's, I have started with the supported F5 template [here](https://github.com/F5Networks/f5-azure-arm-templates/tree/master/supported/failover/same-net/via-lb/3nic/new-stack/payg) but made some modifications to this template in order to build out a full demo environment. 

## Advanced technical details for this demo
* PaloAlto VM's can be bootstrapped by configuring the CustomData field in the ARM template, which contains the details of an Azure file share that contains special configuration files. The instructions for this from PaloAlto are [here](https://docs.paloaltonetworks.com/vm-series/8-1/vm-series-deployment/bootstrap-the-vm-series-firewall/bootstrap-the-vm-series-firewall-in-azure). The major hurdle to this is the requirement of an existing Storage Account configured with a Files service (not a Blob service) that is required by PaloAlto VM's.
* In order to access an Azure file server, [you must use a Storage Account Key](https://docs.microsoft.com/en-us/azure/storage/files/storage-how-to-use-files-windows). You might prefer to pre-create a Storage Account with pre-defined configuration files for this task, but you would then be required to store a Storage Account Key in the code (or demo instructions) of your repo - a bad practice, even if the files are intended to be public facing. 
* To overcome the above problem, this demo creates a StorageAccount as part of this template, and then runs an [azcopy command](https://docs.microsoft.com/en-us/azure/storage/common/storage-ref-azcopy-copy) in an Azure container to copy the files required (hosted in this repo) into the storage account. I followed [this helpful guide](https://samcogan.com/run-scripts-in-arm-deployments-with-aci) to do this.

## Support
This template has been developed for example and demonstration purposes. Please submit an issue via GitHub if you would like a feature added or have problems deploying this yourself.
