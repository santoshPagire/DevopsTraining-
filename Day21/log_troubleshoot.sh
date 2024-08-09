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
