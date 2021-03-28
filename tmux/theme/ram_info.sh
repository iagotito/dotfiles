#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

get_percent()
{
	total_mem=$(free -h | awk '/^Mem/ {print $2}')
	memory_usage=$(free -g | awk '/^Mem/ {print $3}')
	echo $memory_usage\G\B/${total_mem%Gi}\G\B
}

main()
{
	RATE="5"
	ram_percent=$(get_percent)
	echo "RAM $ram_percent"
	sleep $RATE
}

#run main driver
main
