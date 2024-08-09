# Project 01: Shell Scripting and System Monitoring

## Project Overview

This capstone project integrates shell scripting with system monitoring and log management. The aim is to create a suite of automated tools using shell scripts for log management, and to implement system performance monitoring using Prometheus and Node Exporter. The project covers scripting fundamentals, log management, and monitoring setup, providing a comprehensive approach to system administration and performance analysis.

## Project Deliverables

### 1. Shell Scripts for Basic Operations

**Task:** Develop shell scripts to perform essential system operations.

**Scripts:**
- `disk_usage.sh`: Checks and logs disk usage.
- `memory_usage.sh`: Checks and logs memory usage.
- `cpu_load.sh`: Checks and logs CPU load.
+ metrics.sh
```bash
#!/bin/bash

LOGFILE="system_metrics.log"

log_message() {
    echo "$1" | tee -a "$LOGFILE"
}

check_disk_usage() {
    log_message "Disk Usage:"
    df -h | tee -a "$LOGFILE"
}

check_memory_usage() {
    log_message "Memory Usage:"
    free -h | tee -a "$LOGFILE"
}

check_cpu_load() {
    log_message "CPU Load:"
    top -bn1 | grep "Cpu(s)" | tee -a "$LOGFILE"
}

check_disk_usage
check_memory_usage
check_cpu_load

# Error handling
if [ $? -ne 0 ]; then
    log_message "Error occurred while collecting system metrics."
    exit 1
fi

log_message "System metrics collection completed successfully."

```
make script executable:
```bash
chmod 744 metrics.sh
```

run script:
```bash
./metrics.sh
```
![alt text](<images/Screenshot from 2024-08-09 08-39-17.png>)
![alt text](<images/Screenshot from 2024-08-09 08-39-27.png>)

### 2. Log Management Script

**Task:** Create a script to automate log management tasks.

**Script:**
- `log_management.sh`: Automates log rotation and archiving.
```bash
#!/bin/bash

LOGFILE="log_report.txt"

check_log() {
    echo "logs are shown below :-"
    cat /var/log/syslog | tail -n 4
    echo
}


if [ -n "$LOGFILE" ]; then
    {
        check_log
    } > "$LOGFILE" 

    echo "Report saved to $LOGFILE"
fi

```
make script executable:
```bash
chmod 744 log_management.sh
```
run script:
```bash
./log_management.sh
```
![alt text](<images/Screenshot from 2024-08-09 08-50-16.png>)

### 3. Advanced Shell Scripting - Loops, Conditions, Functions, and Error Handling

**Scripts:**
- `metrics_advance.sh`: Combines disk usage, memory usage, and CPU load checks with advanced scripting techniques.
+ metrics_advance.sh
```bash
#!/bin/bash

LOGFILE="metrics_advance.log"
TMPFILE="/tmp/system_metrics_temp.log"

# Ensure the log file exists and is writable
if [ ! -w "$(dirname "$LOGFILE")" ]; then
    echo "Log directory is not writable: $(dirname "$LOGFILE")" >&2
    exit 1
fi


log_message() {
    local message="$1"
    local timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$timestamp - $message" | tee -a "$LOGFILE"
}

check_disk_usage() {
    log_message "Checking disk usage..."
    df -h > "$TMPFILE" 2>> "$LOGFILE"
    if [ $? -eq 0 ]; then
        log_message "Disk Usage:"
        cat "$TMPFILE" | tee -a "$LOGFILE"
    else
        log_message "Error checking disk usage."
    fi
}

check_memory_usage() {
    log_message "Checking memory usage..."
    free -h > "$TMPFILE" 2>> "$LOGFILE"
    if [ $? -eq 0 ]; then
        log_message "Memory Usage:"
        cat "$TMPFILE" | tee -a "$LOGFILE"
    else
        log_message "Error checking memory usage."
    fi
}

check_cpu_load() {
    log_message "Checking CPU load..."
    top -bn1 | grep "Cpu(s)" > "$TMPFILE" 2>> "$LOGFILE"
    if [ $? -eq 0 ]; then
        log_message "CPU Load:"
        cat "$TMPFILE" | tee -a "$LOGFILE"
    else
        log_message "Error checking CPU load."
    fi
}

{
    log_message "Starting system metrics collection."
    check_disk_usage
    check_memory_usage
    check_cpu_load
    log_message "System metrics collection completed successfully."
} || {
    log_message "An error occurred during the system metrics collection."
    exit 1
}

# Clean up temporary file
rm -f "$TMPFILE"

```
make script executable:
```bash
chmod 744 metrics_advance.sh
```
```bash
./metrics_advance.sh
```
![alt text](<images/Screenshot from 2024-08-09 08-55-02.png>)
![alt text](<images/Screenshot from 2024-08-09 08-55-22.png>)

### 4. Log Checking and Troubleshooting

**Task:** Develop a script to analyze system and application logs.

**Script:**
- `log_troubleshooting.sh`: Analyzes logs for common issues and provides troubleshooting steps.
+ log_troubleshooting.sh
```bash
#!/bin/bash

LOGFILES=("/var/log/syslog" "/var/log/auth.log")
REPORT_FILE="log_troubleshooting_report.log"

# Function to check for common issues
check_logs() {
    for logfile in "${LOGFILES[@]}"; do
        if [ -f "$logfile" ]; then
            echo "Checking $logfile" | tee -a "$REPORT_FILE"
            grep -i "out of memory\|failed\|error" "$logfile" | tee -a "$REPORT_FILE"
        else
            echo "$logfile does not exist" | tee -a "$REPORT_FILE"
        fi
    done
}

# Function to provide troubleshooting steps
troubleshoot() {
    echo "Troubleshooting steps:" | tee -a "$REPORT_FILE"
    echo "1. Check system memory and processes using 'top' or 'free'." | tee -a "$REPORT_FILE"
    echo "2. Verify service status using 'systemctl status <service>'." | tee -a "$REPORT_FILE"
    echo "3. Inspect configurations or restart services as needed." | tee -a "$REPORT_FILE"
}

check_logs
troubleshoot

# Error handling
if [ $? -ne 0 ]; then
    echo "Log checking or troubleshooting failed" | tee -a "$REPORT_FILE"
    exit 1
fi

```
make script executable:
```bash
chmod 744 log_troubleshooting.sh
```
```bash
./log_troubleshooting.sh
```
![alt text](<images/Screenshot from 2024-08-09 08-57-37.png>)

### 5. Installation and Setup of Prometheus and Node Exporter

**Task:** Install and configure Prometheus and Node Exporter.
```bash
wget https://github.com/prometheus/prometheus/releases/download/v2.53.1/prometheus-2.53.1.linux-amd64.tar.gz
```
![alt text](<images/Screenshot from 2024-08-08 17-35-28.png>)
+ unzip prometheus 
```bash
tar -xvf prometheus-2.53.1.linux-amd64.tar.gz
cd prometheus-2.53.1.linux-amd64/
```
Configure Prometheus:
   Update the `prometheus.yml` configuration file to include Node Exporter as a scrape target.
   ```yml
    scrape_configs:
    - job_name: 'node_exporter'
    static_configs:
        - targets: ['localhost:9100']
   ```

+ start prometheus
```bash
./prometheus 
```
![alt text](<images/Screenshot from 2024-08-08 17-54-27.png>)
![alt text](<images/Screenshot from 2024-08-08 17-55-17.png>)

+ download node_exporter
```bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
```
+ unzip node_exporter
```bash
tar -xvf node_exporter-1.8.2.linux-amd64.tar.gz
cd node_exporter-1.8.2.linux-amd64/
```
+ start node_exporter
```bash
./node_exporter 
```
![alt text](<images/Screenshot from 2024-08-08 18-03-22.png>)
### 6. Prometheus Query Language (PromQL) Basic Queries

**Task:** Create PromQL queries to monitor system performance.

**Queries and Dashboard Setup:**
- Example PromQL queries for monitoring system performance.
+ Memory Usage Percentage:
![alt text](<images/Screenshot from 2024-08-08 18-32-57.png>)
![alt text](<images/Screenshot from 2024-08-08 18-33-36.png>)
+ CPU Usage:
![alt text](<images/Screenshot from 2024-08-08 18-35-36.png>)
![alt text](<images/Screenshot from 2024-08-08 18-38-38.png>)

