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
