#!/bin/sh
echo "Install the repository configuration"
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > ./microsoft-prod.list
sudo cp ./microsoft-prod.list /etc/apt/sources.list.d/

echo Install a public key to access the repository
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo cp ./microsoft.gpg /etc/apt/trusted.gpg.d/

echo "Install Moby, a container runtime, and its CLI commands"
sudo apt-get update
sudo apt-get install -y moby-engine
sudo apt-get install -y moby-cli

echo "Download and install the IoT Edge Security Daemon"
sudo apt-get install -y iotedge

echo "Input IoT Edge Device Connection String:"
read connectionstring
sudo sed "s#device_connection_string: \"\"#device_connection_string \""$connectionstring"\"#" /etc/iotedge/config.yaml
