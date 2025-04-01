#!/usr/bin/env bash


find . -maxdepth 1 -mindepth 1 \
\( -path "./utility" -o -path "./docs" -o -path "./.git" -o -path "./venv" \) -prune \
-o -type d -print0 | \
while read -d '' dir ; do
  num_in_dir=$(find $dir -name "*.md" | wc -l)
  #printf "%5d markdown files in directory %s\n" "$num_in_dir" "$dir"
  dir_name=$(echo "$dir" | cut -d/ -f2)
  num_in_readme="$(rg "]\("$dir_name"/" README.md -c)"
  if [[ $num_in_dir -gt $num_in_readme ]]; then
    printf "entries in %s is greater than entries in readme.md!\n" $dir
  elif [[ $num_in_dir -lt $num_in_readme ]]; then
    printf "entries in %s is less than entries in readme.md!\n" $dir
  fi
done

