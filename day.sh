#!/usr/bin/env bash

day="$1"
dir="d$day"

session="$(cat .sessionid)"

echo "Creating directory $dir"
mkdir -p "$dir"
echo "Trying to download input"
curl "http://adventofcode.com/2017/day/$day/input" -H "Cookie: session=$session" -o "$dir/input" || echo "Failed"
