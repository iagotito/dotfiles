#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

# normalize the percentage string to always have a length of 5
normalize_percent_len() {
	# the max length that the percent can reach, which happens for a two digit number with a decimal house: "99.9%"
	max_len=5
	percent_len=${#1}
	let diff_len=$max_len-$percent_len
	# if the diff_len is even, left will have 1 more space than right
	let left_spaces=($diff_len+1)/2
	let right_spaces=($diff_len)/2
	printf "%${left_spaces}s%s%${right_spaces}s\n" "" $1 ""
}

get_percent()
{
	percent=$(LC_NUMERIC=en_US.UTF-8 top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
	normalize_percent_len $percent
}

main()
{
	RATE="5"
	cpu_percent=$(get_percent)
	echo "CPU $cpu_percent"
	sleep $RATE
}

# run main driver
main
