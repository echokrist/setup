#!/bin/bash

# Set CPU Scheduler to performance on all CPU cores.
for cpu in /sys/devices/system/cpu/cpu?; do
    sudo echo "performance" > $cpu/cpufreq/scaling_governor
done


for cpu in /sys/devices/system/cpu/cpufreq/policy?; do
      sudo echo "performance" > $cpu/scaling_governor
done

for cpu in /sys/devices/system/cpu/cpufreq/policy??; do
      sudo echo "performance" > $cpu/scaling_governor
done

echo "Performance mode enabled!"
