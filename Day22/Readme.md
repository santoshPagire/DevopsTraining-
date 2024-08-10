# Project 01

## Project Breakdown

### 1. Configuring Jobs and Targets
- **Task:** Set up a Prometheus server to monitor multiple services running on different nodes.
- **Deliverables:**
  - Configure Prometheus with jobs for monitoring different services like web servers, databases, and system metrics.
+ prometheus.yml
```PromQL
# my global config
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
           - localhost:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"
   - "alert_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "prometheus"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ["localhost:9090"]



  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']

  # webserver target setup
  - job_name: "nginx"
    static_configs:
      - targets: ["13.235.16.69:80"]

  # database target setup
  - job_name: "mysql"
    static_configs:
      - targets: ["13.235.16.69:9104"]

  # system metrics setup
  - job_name: "system_metrics"
    static_configs:
      - targets: ["13.235.16.69:9100"]

```

### 2. Using Exporters (Node Exporter)
- **Task:** Use Node Exporter to monitor system-level metrics like CPU, memory, disk usage, and network statistics.
![alt text](<images/Screenshot from 2024-08-10 17-46-59.png>)


### 3. Hands-on Exercise: Setting Up Exporters
- **Task:** Configure at least two different types of exporters (e.g., Node Exporter and MySQL Exporter) and integrate them with Prometheus.
![alt text](<images/Screenshot from 2024-08-10 17-46-59.png>)


### 4. Introduction to PromQL
- **Task:** Write basic queries to retrieve metrics like average CPU usage, memory consumption, and disk I/O over time.
+ Average CPU Usage Over Time
```PromQL
100 - 100 * (avg by (group, instance, job) (irate(node_cpu_seconds_total{mode="idle"}[5m])))
```
![alt text](<images/Screenshot from 2024-08-10 18-07-09.png>)
![alt text](<images/Screenshot from 2024-08-10 18-07-48.png>)
+ Average Memory Consumption Over Time
```PromQL
avg_over_time((node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes)[1h:5m])
```
![alt text](<images/Screenshot from 2024-08-10 17-15-44.png>)
![alt text](<images/Screenshot from 2024-08-10 17-16-03.png>)
+ Average Disk I/O Over Time
```PromQL
avg(rate(node_disk_written_bytes_total[5m])) by (instance)
```
![alt text](<images/Screenshot from 2024-08-10 18-10-08.png>)
![alt text](<images/Screenshot from 2024-08-10 18-11-08.png>)

### 5. Basic Queries (Selectors, Functions, Operators)
- **Task:**
  - Write PromQL queries to calculate the 95th percentile of CPU usage.
  - Use functions like `rate()`, `increase()`, and `histogram_quantile()` to perform more complex analysis.

### 6. Advanced Queries and Aggregations
- **Task:** 
  - Write queries to calculate the total memory usage across all nodes.
  ```PromQL
  sum by (instance)(node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes)
  ```
![alt text](<images/Screenshot from 2024-08-10 16-34-16.png>)
  - Aggregate data to find the maximum disk space usage among all nodes.
  ```PromQl
  max(node_filesystem_size_bytes - node_filesystem_free_bytes)
  ```
  ![alt text](<images/Screenshot from 2024-08-10 16-38-37.png>)

### 7. Configuring Alertmanager
- **Task:**
  - Configure Alertmanager with Prometheus.
![alt text](<images/Screenshot from 2024-08-10 17-42-41.png>)


### 8. Writing Alerting Rules
- **Task:** 
  - Create alerting rules for high CPU usage, memory leaks, and disk space running low.
![alt text](<images/Screenshot from 2024-08-10 17-43-57.png>)

### 9. Setting Up Notification Channels (Email, Slack, etc.)
- **Task:** Integrate Alertmanager with multiple notification channels like Email and Slack.
  - Integrate Slack for real-time alerts and notifications.
![alt text](<images/Screenshot from 2024-08-10 17-38-41.png>)
![alt text](<images/Screenshot from 2024-08-10 17-39-05.png>)
+ Setting up alertmanager.yml
![alt text](<images/Screenshot from 2024-08-10 17-54-55.png>)

### 10. Hands-on Exercise: Creating Alerts
- **Task:** Test the entire alerting pipeline by creating and triggering custom alerts.
- **Deliverables:**
  - Simulate a scenario where a node exceeds 90% CPU usage and ensure alerts are triggered and sent to both Email and Slack.
  - Validate the alerts in both notification channels.
![alt text](<images/Screenshot from 2024-08-10 16-00-22.png>)
![alt text](<images/Screenshot from 2024-08-10 16-01-22.png>)
