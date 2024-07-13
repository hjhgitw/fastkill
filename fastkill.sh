#!/bin/bash

# Function to kill processes using more than specified CPU percentage
kill_high_cpu() {
    ps -eo pid,ppid,comm,%cpu --sort=-%cpu | awk '$4>80.0 {print $1}' | xargs -I {} kill -9 {}
}

# Function to kill processes using more than specified memory percentage
kill_high_mem() {
    ps -eo pid,ppid,comm,%mem --sort=-%mem | awk '$4>50.0 {print $1}' | xargs -I {} kill -9 {}
}

echo "Killing processes using more than 80% CPU..."
kill_high_cpu

echo "Killing processes using more than 50% memory..."
kill_high_mem

echo "Done."
