# Data Center Fabric

This project is a sister of another my project `Service Provider Fabric`. At some time in future they will be merged into a single one, but as of today they are splitted. The primar focus of this project is to make sure the freshly shipped network function is automatically provisioned (zero-touch) up to desired state including infrastructure and customer services and is integrated into data center operation.

## Currently used network operation systems
1. Arist EOS 4.21.1.1F
2. Cisco IOS XR 6.5.1
3. Nokia SR OS 16.0.R7
4. Cumulus Linux 3.7.6

## Zero Touch Provisioning (ZTP)
There is a full infrastructure enablers' stack (DHCP, DNS, FTP and HTTP) is deployed as Docker containers. Once the stack is launched after NetBox is up and running the following is happening:
- Container with DHCP is launched and `dhcpd.conf` is automaically populated with entries from NetBox for OOB management subnet. In case there are IP/MAC pairs present in the device configuration, the static entries are created as well. For `Cumulus` and `Arista` there are corresponding entries added with link to ZTP script.
- Container with DNS is launched and `named.conf` is automaically populated with zone names from NetBox for OOB management subnet. The files for forward and reverse (both IPv4 and IPv6) zones are automatically created and filled in with the entries of IPv4/IPv6 addresses of OOB interfaces matched to the hostnames.
- Container with FTP server is launched and automatically populated with content, what must be shared (currently, only test file).
- Container with HTTP server is launched and ZTP scripts are automatically generated based on the information from NetBox.

## Docker containers
In the folder `containers` you can find source files of the infrastructure Docker containers build on top of `Alpine Linux` to reduce usage of disk space.

## Version

The current version of this repository is `0.5.0`.

## Prerequisites

You have installed Netbox (https://github.com/digitalocean/netbox) to document your infrastructure, as it's used as "the source of truth" and modelling for data center infrastructure and services. 

## Change log

Version `0.1`.
1. Initial release
2. Integration of Ansible with NetBox over REST API to retreive information needed to create configuration for Cumulus Linux.
3. Automatic provisioning of Cumulus VX using information extracted in previous point.

Version `0.1.1`.
1. Topology is added within `topology` folder.

Version `0.2`.
1. Automatic provisioning of Arista EOS for underlay IP Fabric.
2. Automatic provisioning of Cisco IOS XR for underlay IP Fabric.

Version `0.3`.
1. Added folder `containers` with Dockerfiles for infrastructure enablers.
2. Folder `containers\dns` contains the Dockerfile for DNS Server based on BIND9 and Alpine Linux base image.
3. Folder `contaienrs\ftp` contains the Dockerfile for FTP Server based on VSFTP and Alpine Linux base image.
4. Folder `contaienrs\http` contains the Dockerfile for HTTP Server based on NGINX and Alpine Linux base image.
5. Folder `contaienrs\dhcp` contains the Dockerfile for DHCP Server based on ISC DHCP and Alpine Linux base image.

Version `0.3.1`.
1. The role `cloud_docker` is copied from `The Service Provider Fabric` to setup the Docker on CentOS.
2. New role `cloud_enabler` is created to bring life DHCP, DNS, FTP and HTTP services automatically. More details in `ansible\README.md`.

Version `0.3.2`.
1. The DHCP config file `dhcpd.conf` is automatically populated with data from NetBox over REST API using Ansible. The information is populated for the data centre `bln`.
2. The DNS config file `named.cond` is automatically populated with data from NetBox over REST API using Ansible. The information is populated for the data centre `bln`.
3. The filename for forward and reverse zones (both IPv4 and IPv6) is automatically generated based on the domain given in Ansible variables `group_vars/linux` and OOB subnet extracted from NetBox.
4. The DNS forward zone is automatically filled with info from NetBox over REST API using Ansible.
5. The DNS reverse zone for IPv4 is automatically filled with info from NetBox over REST API using Ansible.
6. The DNS reverse zone for IPv6 is automatically filled with info from NetBox over REST API using Ansible.

Version `0.3.3`.
1. ZTP for Arista is added.
2. Some text updates.
3. Updated management topology with the Docker cloud on the management host.

Version `0.3.4`.
1. Some minor templates' and tasks' updates.

Version `0.3.5`.
1. Fixed some problem with Docker installation for role `cloud_docker` caused by imporper `pip` behavior and missing folder.

Version `0.3.6`.
1. In the `containers` folder added information about Telegraf, InfluxDB and Grafana.
2. There are two containers with Telegraf `telegraf_snmp` and `telegraf_syslog` as they collect different information.

Version `0.3.7`.
1. The role `cloud_enabler` is extended with monitoring capabilities based on Telegraf, InfluxDB and Grafana using approach from `Service Provider Fabric`.
2. Information from data centre switches is collected using SNMP and Syslog, from Docker containers using Syslog.

Version `0.3.8`.
1. Configuration of SNMP on Cumulus is added to `dc_underlay` role. Arista/Cisco to add.
2. SNMPv3 with authentication and encryption is collected over IPv6.
3. Dashboards are added to `containers/grafana/dashboards` folder.
4. The role `dc_underlay` is updated so that for Cumulus Linux rsyslog/snmpd services are restarted.
5. Syslog configuration is pushed to the Cumulus devices during provisioning of the `dc_underlay` role.
6. Management topology is updated with additional four containers.
7. All the containers are moved to user-defined Docker bridge running both IPv4/IPv6.
8. As a quick and dirty lab setup with 6x Cumulus VXs, there are two shell scripts in the `cumulus_kvm` folder. Refer there for more details.

Version `0.3.9`.
1. Problem with ntp in VRF for the `Cumulus` switches is fixed.

Version `0.4.0`.
1. The Docker container with Kapacitor to proces the data real-time is added, but configuration is still ongoing.

Version `0.4.1`.
1. The Docker container with Kapacitor is automatically deployed together with other `enabler` infrastructure.
2. It connects to the `dcf_influxdb` on HTTPS and subscribe to `dcf_syslog` database to get all syslog messages.
3. There is one TICK script currently which looks for DHCPACK from `dcf_influxdb` messages and triggers alert action (shell script) upon getting it.

Version `0.4.2`.
1. Kapacitor triggers automatic full provisioning of the full `dc_underlay` role for a host with the specific management IP address.
2. Kapacitor uses existing role `dc_underlay` with an additional ad-hoc variable.

Version `0.4.3`.
1. The provisioning is done only for devices documented in NetBox with the status `Planned`. The device having any other status isn't provisioned. That's applicable both for manual execution and automatic one by Kapacitor.

Version `0.5.0`.
1. Some minor modification of the text in `README.md` files.
2. Provisioning of 3 described Grafana dashboards are done automatically during the deployment of the Grafana container.

# Do you want to automate network like a profi?
Join the network automation course: http://training.karneliuk.com

(c) 2016-2019 karneliuk.com
