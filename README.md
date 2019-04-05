# Data Center Fabric

This project is a sister of another my project `Service Provider Fabric`. At some time in future they will be merged into a single one, but as of today they are splitted. The primar focus of this project is to make sure the freshly shipped network function is automatically provisioned (zero-touch) up to desired state including infrastructure and customer services and is integrated into data center operation.

# Currently used network operation systems
1. Arist EOS 4.21.1.1F
2. Cisco IOS XR 6.5.1
3. Nokia SR OS 16.0.R5
4. Cumulus Linux 3.7.3

# Version

The current version of this repository is `0.1.1`.

# Prerequisites

You have installed Netbox (https://github.com/digitalocean/netbox) to document your infrastructure, as it's used as "the source of truth" and modelling for data center infrastructure and services. 

# Change log

Version `0.1`.
1. Initial release
2. Integration of Ansible with NetBox over REST API to retreive information needed to create configuration for Cumulus Linux.
3. Automatic provisioning of Cumulus VX using information extracted in previous point.

Version `0.1.1`.
1. Topology is added within `topology` folder.
