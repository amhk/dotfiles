#!/bin/bash

while true; do
        # network
        device="$(nmcli -t -f device con show --active | grep -v -e '^lo$')"
        if [[ "${device}" ]]; then
		network_state="$(nmcli -g general.state,general.connection device show $device | tr '\n' ' ')"
        else
                network_state="no active network connection"
        fi

        # battery
        battery="$(cat /sys/class/power_supply/BAT0/status) $(cat /sys/class/power_supply/BAT0/capacity)%"

        # time and date
        date="$(date +"%a  %Y-%m-%d  %H:%M")"

        # output
        echo "${network_state}  |  ${battery}  |  ${date}"

        # for debugging purposes, only loop if explicitly told to
        if [[ "$1" != "--loop" ]]; then
                break
        fi

        sleep 1
done
