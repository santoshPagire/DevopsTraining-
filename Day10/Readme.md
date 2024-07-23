# Project Overview: 
Develop a comprehensive shell script for sysops to automate system monitoring and generate detailed reports. The script will leverage advanced Linux shell scripting techniques to monitor system metrics, capture logs, and provide actionable insights for system administrators.

## Script Initialization:
Initialize script with necessary variables and configurations.
Validate required commands and utilities availability.
## System Metrics Collection:
+ Monitor CPU usage, memory utilization, disk space, and network statistics.
```bash
(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
(df -h | awk '$NF=="/"{printf "%s", $5}')
```
+ Capture process information including top processes consuming resources.
```bash
(free | grep Mem | awk '{print $3/$2 * 100.0}')
```
## Log Analysis:
+ Parse system logs (e.g., syslog) for critical events and errors.
```bash
(tail -n 200 /var/log/syslog | grep -iE 'error|critical')
```
+ Generate summaries of recent log entries based on severity.
```bash
(tail -n 20 /var/log/syslog)
```
## Health Checks:
+ Check the status of essential services (e.g., Nginx, MySQL).
```bash
systemct status nginx
```
+ Verify connectivity to external services or databases.
## Alerting Mechanism:
+ Implement thresholds for critical metrics (CPU, memory) triggering alerts.
+ Send email notifications to sysadmins with critical alerts.
## Report Generation:
+ Compile all collected data into a detailed report.
+ Include graphs or visual representations where applicable.
## Automation and Scheduling:
+ Configure the script to run periodically via cron for automated monitoring.
Edit crontab file
```bash
crontab -e
```
Add following content in it
```bash
* */1 * * * /home/einfochips/Desktop/SP/Training/Day10/sysops.sh
```
check list of crontab list
```bash
crontab -l
```
+ Ensure the script can handle both interactive and non-interactive execution modes.
## User Interaction:
+ Provide options for interactive mode to allow sysadmins to manually trigger checks or view specific metrics.
+ Ensure the script is user-friendly with clear prompts and outputs.
## Documentation:
+ Create a README file detailing script usage, prerequisites, and customization options.
+ Include examples of typical outputs and how to interpret them.


# Solution

Create Script File
```bash
nano system_ops.sh
``` 
Add Following Code in it

```bash
#!/bin/bash

REPORTDIR="/home/einfochips/Desktop/SP/Training/Day10/"
ALERT_THRESHOLD_CPU=75   
ALERT_THRESHOLD_MEM=40  
SERVICE_STATUS=("nginx" "mysql")
EXTERNAL_SERVICES=("google.com" "mysql://db.test.com")

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/")
MEMORY_USAGE=$(free | awk '/Mem/{printf("%.2f"), $3/$2*100}')

System_Metrics() {
    echo -e "\n CPU Usage: "
    echo "CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/")"
    echo "MEMORY_USAGE=$(free | awk '/Mem/{printf("%.2f"), $3/$2*100}')"
    echo "DISK_SPACE=$(df -h / | awk '/\//{print $(NF-1)}')"

    echo -e "\n Network Statistics: "
    echo "NETWORK_STATS=$(netstat -i)"

    echo -e "\n Top Processes: "
    echo "TOP_PROCESSES=$(top -bn 1 | head -n 10)"
}

Log_analysis() {
    echo -e "\Recent Critical Events: "
    echo "CRITICAL_EVENTS=$(tail -n 200 /var/log/syslog | grep -iE 'error|critical')"

    echo -e "\n Recent Logs: "
    echo "RECENT_LOGS=$(tail -n 20 /var/log/syslog)"
}

Health_check() {
    echo -e "\n Service Status: "
    for service in "${SERVICE_STATUS[@]}"; do
        systemctl is-active --quiet "$service"
        if [ $? -eq 0 ]; then
            echo "   $service is running."
        else
            echo "   Alert: $service is not running."
        fi
    done

    echo -e "\n Connectivity Check: "
    for service in "${EXTERNAL_SERVICES[@]}"; do
        ping -c 1 "$service" >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "   Connectivity to $service is okay." 
        else
            echo "   Alert: Unable to connect to $service."
        fi
    done

}

if (( $(echo "$CPU_USAGE >= $ALERT_THRESHOLD_CPU" | bc -l) )); then
    echo "High CPU Usage Alert: $CPU_USAGE%"
fi

if (( $(echo "$MEMORY_USAGE >= $ALERT_THRESHOLD_MEM" | bc -l) )); then
    echo "High Memory Usage Alert: $MEMORY_USAGE%"
fi


mkdir -p "$REPORTDIR"
REPORTFILE="$REPORTDIR/sysreport_$(date +'%Y-%m-%d_%H-%M-%S').txt"
echo "System Report $(date)" >> "$REPORTFILE"
System_Metrics >> "$REPORTFILE"
Log_analysis>> "$REPORTFILE"
Health_check >> "$REPORTFILE"

echo "Select an option:
1. Check system metrics
2. View logs
3. Check service status
4. Exit"

read choice

case $choice in
    1) System_Metrics
       ;;
    2) Log_analysis
       ;;
    3) Health_check
       ;;
    4) exit ;;
    *) echo "Invalid option";;
esac
```

Give neccessory permissions to File for execution
```bash
chmod 755 system_ops.sh
```
Run the script using following command
```bash
./system_ops.sh
```
After run the script it will create report file which will store all info like CPU usage, memory usage and all.
![alt text](<image/Screenshot from 2024-07-23 10-26-59.png>)
![alt text](<image/Screenshot from 2024-07-22 18-46-07.png>)
![alt text](<image/Screenshot from 2024-07-22 18-47-01.png>)
![alt text](<image/Screenshot from 2024-07-22 18-47-33.png>)




# Project 2 (Jenkins)

## Step 1:
+ Login to jenkins.
+ From dashboard give name to project.
+ Then select Freestyle project and click ok.

## step 2:
+ In Source code management select Git and add your repository link which contain java code.
![alt text](<image/Screenshot from 2024-07-23 10-36-07.png>)
+ Make sure your repository is public if private then need to give credentials.
+ Select Branch name.
![alt text](<image/Screenshot from 2024-07-23 10-51-35.png>)

## Step 3:
+ For periodically trigger pipeline we need to define period 
+ In Build Triggers select option Build periodically and add following line which trigger pipeline every 5 minutes.
```
*/5 * * * *
``` 
![alt text](<image/Screenshot from 2024-07-23 10-52-09.png>)
## Step 4:
+ To run the java code we need to provide commands we provide that in Execute shell.
+ For that In Build Steps select Execute shell and add commands in this case add following lines.
```
javac Sample.java
java Sample
```
![alt text](<image/Screenshot from 2024-07-23 10-37-03.png>)
and click save.

## Step 5:
+ To build project click on Build
+ Then First build will create ,click on it.
![alt text](<image/Screenshot from 2024-07-23 10-37-35.png>)
+ then click on Console output we can see the output of your java code.
![alt text](<image/Screenshot from 2024-07-23 10-38-30.png>)