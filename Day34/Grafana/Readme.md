# Grafana Installation on Debian/Ubuntu

This task explains how to install Grafana and its dependencies on Debian or Ubuntu systems using the APT repository.

## Prerequisites

Before installing Grafana, you need to install some prerequisite packages.

```bash
sudo apt-get install -y apt-transport-https software-properties-common wget
```
![alt text](<images/Screenshot from 2024-08-29 12-11-06.png>)

## Import the GPG Key

To ensure the authenticity of the Grafana packages, import the GPG key:

```bash
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
```
![alt text](<images/Screenshot from 2024-08-29 12-11-29.png>)

## Add Grafana Repository

To add the repository for Grafana stable releases:

```bash
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
```
![alt text](<images/Screenshot from 2024-08-29 12-11-29.png>)
## Update Package List

Update the list of available packages:

```bash
sudo apt-get update
```
![alt text](<images/Screenshot from 2024-08-29 12-11-48.png>)

## Install Grafana

To install Grafana Open Source (OSS):

```bash
sudo apt-get install grafana
```
![alt text](<images/Screenshot from 2024-08-29 12-12-18.png>)

To install Grafana Enterprise:

```bash
sudo apt-get install grafana-enterprise
```
![alt text](<images/Screenshot from 2024-08-29 12-12-34.png>)

## Enable and Start Grafana

Enable Grafana to start on boot:

```bash
sudo systemctl enable grafana-server.service
```
![alt text](<images/Screenshot from 2024-08-29 12-12-57.png>)

Start Grafana:

```bash
sudo systemctl start grafana-server.service
```

Check the status of the Grafana server:

```bash
sudo systemctl status grafana-server.service
```
![alt text](<images/Screenshot from 2024-08-29 12-13-10.png>)

 Grafana should be running and accessible at `http://localhost:3000` by default.
 ![alt text](<images/Screenshot from 2024-08-29 12-04-17.png>)

 ![alt text](<images/Screenshot from 2024-08-29 12-05-03.png>)


 # Prometheus Installation on Debian/Ubuntu

 download file:
 ```bash
 wget https://github.com/prometheus/prometheus/releases/download/v2.53.1/prometheus-2.53.1.linux-amd64.tar.gz
 ```
 unzip prometheus file
 ```bash
 tar -xvf prometheus-2.53.1.linux-amd64.tar.gz
 ```
 ```bash
 cd prometheus-2.53.1.linux-amd64/
 ```
 ![alt text](<images/Screenshot from 2024-08-29 21-42-11.png>)
 start prometheus
 ```bash
 ./prometheus 
 ```
 ![alt text](<images/Screenshot from 2024-08-29 21-42-30.png>)
 ## Node exporter

 download node exporter
 ```bash
 wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
 ```
 unzip node_exporter
 ```bash
 tar -xvf node_exporter-1.8.2.linux-amd64.tar.gz
 ```
 ```bash
 cd node_exporter-1.8.2.linux-amd64/
 ```
 start node_exporter
 ```bash
 ./node_exporter 
 ```
 ![alt text](<images/Screenshot from 2024-08-29 21-42-51.png>)

 Connection of prometheus and grafana

 ![alt text](<images/Screenshot from 2024-08-29 13-02-08.png>)
 ![alt text](<images/Screenshot from 2024-08-29 13-04-13.png>)
