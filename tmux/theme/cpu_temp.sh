#!/usr/bin/env bash

# normalize the percentage string to always have a length of 3
# the temp will not show the decimal places
normalize_temp_len() {
	# the max length that the percent can reach, which happens for a two digit number
	max_len=2
  temp=$(echo "$1" | awk '{printf "%.0f\n", $1}')
	temp_len=${#temp}
	let diff_len=$max_len-$percent_len
	# if the diff_len is even, left will have 1 more space than right
	let left_spaces=($diff_len+1)/2
	let right_spaces=($diff_len)/2
	printf "%${left_spaces}s%s%${right_spaces}s\n" "" $temp ""
}
°

get_temp()
{
  core_temps=$(sensors | grep 'Core [0-9]' | awk '{print $3}' | sed 's/+//' | sed 's/.C//')

  # Use awk for floating-point arithmetic to calculate the average
  average=$(echo "$core_temps" | awk '{sum += $1; count++} END {print sum / count}' | sed 's/,/./')

  normalize_temp_len $average
}

main()
{
	RATE="5"
  cpu_temp=$(get_temp)
	echo "$cpu_temp°C"
	sleep $RATE
}

main
