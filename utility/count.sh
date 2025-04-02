#!/usr/bin/env bash


find . -maxdepth 1 -mindepth 1 \
\( -path "./utility" -o -path "./docs" -o -path "./.git" -o -path "./venv" \) -prune \
-o -type d -print0 | \
while read -d '' dir ; do
  num_in_dir=$(find $dir -name "*.md" | wc -l)
  #printf "%5d markdown files in directory %s\n" "$num_in_dir" "$dir"
  md_files=$(find $dir -name "*.md" | cut -d/ -f3)
  #printf "markdown files in %s are:\n%s\n" "$dir" "$md_files"
  #printf "\n"

  for md in $md_files
  do
    if ! rg "$md" README.md > /dev/null 2>&1
    then
      printf "The $md file in $dir does not exsit in README.md!\n\n"
    fi
  done

  dir_name=$(echo "$dir" | cut -d/ -f2)
  num_in_readme="$(rg "]\("$dir_name"/" README.md -c)"
  md_files_readme="$(rg "]\("$dir_name"/(.*\.md)" README.md -r '$1' -o)"
  #printf "markdown files in README are:\n%s\n" "$md_files_readme"
  #printf "\n"

  if [[ $num_in_dir -gt $num_in_readme ]]; then
    printf "entries in %s is greater than entries in README.md!\n" $dir
  elif [[ $num_in_dir -lt $num_in_readme ]]; then
    printf "entries in %s is less than entries in README.md!\n" $dir
  fi
done

