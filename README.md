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

## Support
This template has been developed for example and demonstration purposes. Please submit an issue via GitHub if you would like a feature added or have problems deploying this yourself.
