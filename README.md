# azure-f5-palo
Deploys a security stack where PaloAlto firewalls are internet-facing, and F5 BIG-IP's perform application services in a second tier. Uses marketplace (PAYG) images so that license keys or eval keys are not required, but production or long-term use cases can edit the templates as desired to use BYOL licenses and license keys.

## Architecture

## Instructions to deploy

## High Availability
This set of templates will automatically configure HA via Azure Load Balancers.

Palo Alto deployment guide for HA is here: https://docs.paloaltonetworks.com/vm-series/9-0/vm-series-deployment/set-up-the-vm-series-firewall-on-azure/configure-activepassive-ha-for-vm-series-firewall-on-azure.html

## Notes
This set of templates will deploy F5 BIG-IP and PaloAlto VM-Series images from marketplace images. This means you will be charged on a PAYG basis.