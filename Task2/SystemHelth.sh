#1. System Health Monitoring Script: 
#Develop a script that monitors the health of a Linux system.
#  It should check CPU usage, memory usage, disk space, and running processes. 
#  If any of these metrics exceed predefined thresholds (e.g., CPU usage > 80%), 
#  the script should send an alert to the console or a log file. 


#!/bin/bash


check_cpu() {
  cpu_usage=$(top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}')
  if [ $(echo "$cpu_usage >= 80" | bc) -eq 1 ]; then
    echo "CPU usage is high: $cpu_usage%"
  fi
}


check_memory() {
  mem_used=$(free -m | grep Mem | awk '{print $3}')
  mem_total=$(free -m | grep Mem | awk '{print $2}')
  mem_percent=$(( (mem_used * 100) / mem_total ))
  if [ $mem_percent -gt 80 ]; then
    echo "Memory usage is high: $mem_percent%"
  fi
}


check_disk() {
  disk_used=$(df -h / | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{print $5}')
  disk_total=$(df -h / | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{print $2}')
  disk_percent=$(( (disk_used * 100) / disk_total ))
  if [ $disk_percent -gt 80 ]; then
    echo "Disk usage is high: $disk_percent%"
  fi
}


check_processes() {
  process_count=$(ps aux | wc -l)
  if [ $process_count -gt 1000 ]; then
    echo "High number of running processes: $process_count"
  fi
}

while true; do
  check_cpu
  check_memory
  check_disk
  check_processes
  sleep 60
done
