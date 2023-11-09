#!/bin/bash

# Function to calculate the Fibonacci number
fib() {
  local n=$1
  if [ "$n" -eq 0 ]; then
    echo 0
  elif [ "$n" -eq 1 ]; then
    echo 1
  else
    local a=0
    local b=1
    local result=0
    for ((i=2; i<=n; i++)); do
      result=$((a + b))
      a=$b
      b=$result
    done
    echo $result
  fi
}

# Check if the script was called with an argument
if [ $# -ne 1 ]; then
  echo "Usage: $0 <n>"
  exit 1
fi

n=$1
result=$(fib "$n")
echo "Fibonacci number at position $n is $result"