#!/usr/bin/env bash

dir=$1
count_hidden_files=0

greenBold="\033[1m \033[32m"
normal="\033[0m"

# if -h flag is passed count hidden files as well
if [ "$2" == "-h" ]; then
  count_hidden_files=1
fi

if [ $count_hidden_files -eq 1 ]; then
  file_count=$(find "$dir" -type f | wc -l)
else
  file_count=$(find "$dir" -type f -not -path '*/\.*' | wc -l)
fi

echo -e "The number of files in $dir and its subdirectories is: $greenBold$file_count$normal"
