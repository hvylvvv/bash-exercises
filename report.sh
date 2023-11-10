#!/bin/bash
#function to get external IP address
get_external_ip() {
  curl -s ifconfig.me
}

# Function to get system information
get_system_info() {
  echo "Date and Time: $(date)"
  echo "Current User: $USER"
  echo "Internal IP Address: $(hostname -I)"
  echo "Hostname: $(hostname)"
  echo "External IP Address: $(get_external_ip)"
  #echo "Linux Distribution: $(lsb_release -ds || cat /etc/os-release | grep -E '^PRETTY_NAME' | awk -F '"' '{print $2}')"
  echo "Linux Distribution: $(cat /etc/os-release | grep -E '^PRETTY_NAME' | cut -d '"' -f 2)"
  echo "System Uptime: $(uptime -p)"
  echo "Disk Space Usage: $(df -h / | awk 'NR==2 {print "Used: "$3", Free: "$4}')"
  echo "RAM Usage: $(free -h | awk 'NR==2 {print "Total: "$2", Used: "$3", Free: "$4}')"
  echo "CPU Information:"
 # lscpu | grep -E 'Model name|Socket(s)|Core(s) per socket|Thread(s) per core' | sed 's/^/  /'
  lscpu | awk '/^CPU\(s\):|^Core\(s\) per socket:|^CPU MHz:/ {print}'

}

# Generate report and save to a file
get_system_info > system_report.txt

echo "Report generated successfully. Check 'system_report.txt' for details."