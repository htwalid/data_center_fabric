#!/bin/bash

# Extracting the management IPv4 of the node
cat | sed 's/.*DHCPACK on \([[:digit:]\.]\+\?\) to.*/\1/' > /tmp/exec/ip.conf

# Setting IP variable
IP=$(cat /tmp/exec/ip.conf)

# Creating Ansible variable for a specific host
echo "{\"look_for_this_ip\": \"$IP\"}" > /tmp/exec/specific_host.json

# Creating the folder on the destination host or checking it's created
ssh -o "StrictHostKeyChecking=no" aaa@sand9.karneliuk.com "mkdir autotest"

# Copying created var file to the management host
scp -o "StrictHostKeyChecking=no" /tmp/exec/specific_host.json aaa@sand9.karneliuk.com:autotest/specific_host.json

# Connecting to the host with Ansible and trigerring the action
ssh -o "StrictHostKeyChecking=no" aaa@sand9.karneliuk.com "echo 'This action will trigger the launch of the playbook for the provisioning of the full configuration for the $IP' > autotest/autotest_action"