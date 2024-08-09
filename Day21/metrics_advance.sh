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
