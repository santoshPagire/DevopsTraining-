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
