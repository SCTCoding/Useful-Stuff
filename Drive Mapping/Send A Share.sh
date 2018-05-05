#! /bin/bash

# Purpose of this script is to provide a simple double-click share add method.

declare -a paths=(
  # Paths in quotes
)

for i in ${paths[@]}
do
  /usr/bin/sfltool add-item -n "$i" com.apple.LSSharedFileList.FavoriteServers "$i"
	open $path
done
