#!/bin/bash

# Determine the OS
OS="$(uname -s)"
case "$OS" in
    Linux*)     machine=Linux; path_separator="/";;
    Darwin*)    machine=Mac; path_separator="/";;
    CYGWIN*|MINGW32*|MSYS*|MINGW*) machine=Windows; path_separator="\\";;
    *)          machine="UNKNOWN:$OS";;
esac

# Get the hostname
hostname=$(hostname)

# Define the backup directory relative to the script's location
script_dir="$(dirname "$(readlink -f "$0")")"
backup_dir="$script_dir/backups."
mkdir -p "$backup_dir"
# OR Define the backup directory manually by uncommenting this line:
# backup_dir="/afs/acn/infra./arvuti./browsers.search_engines./backups"

# Define the date format
current_date=$(date +%Y-%m-%d)

# Define profile directory locations based on OS
if [[ "$machine" == "Linux" ]]; then
  profiles_ini_files=$(find ~/.mozilla/firefox* -name profiles.ini)
elif [[ "$machine" == "Mac" ]]; then
  profiles_ini_files=$(find ~/Library/Application\ Support/Firefox/Profiles -name profiles.ini)
elif [[ "$machine" == "Windows" ]]; then
  profiles_ini_files=$(find "$APPDATA\\Mozilla\\Firefox\\Profiles" -name profiles.ini)
else
  echo "Unsupported OS"
  exit 1
fi

# Read profile paths and profile names from profiles.ini files
declare -A profile_paths

# Populate profile_paths with paths and corresponding names
for profiles_ini in $profiles_ini_files; do
  profile_dir=$(dirname "$profiles_ini")
  while read -r line; do
    if [[ $line =~ ^\[Profile[0-9]+\]$ ]]; then
      profile_section=$line
    elif [[ $line =~ ^Name= ]]; then
      profile_name=${line#*=}
    elif [[ $line =~ ^Path= ]]; then
      profile_path=${line#*=}
      profile_paths["$profile_dir$path_separator$profile_path"]=$profile_name
    fi
  done < "$profiles_ini"
done

# Iterate over each profile path
for profile_dir in "${!profile_paths[@]}"; do
  profile_name=${profile_paths[$profile_dir]}
  # Use the profile section as the name if profile_name is empty
  if [ -z "$profile_name" ]; then
    profile_name=$(basename "$profile_dir")
  fi
  # Prepend the hostname to the profile name
  profile_name="${hostname}.${profile_name}"
  # Check if search.json.mozlz4 exists in the profile directory
  search_file="$profile_dir${path_separator}search.json.mozlz4"
  if [ -f "$search_file" ]; then
    # Create the backup file name
    backup_file="$backup_dir/search.$current_date.${profile_name}.json.mozlz4"
    # Copy the search.json.mozlz4 to the backup directory with the new name
    cp "$search_file" "$backup_file"
    echo "Copied: $search_file"
    echo "to: $backup_file"
  else
    #~ echo "DEBUG: search.json.mozlz4 not found for path: $profile_dir"
  fi
  echo "----------------------------"
done

ls -lsah "$backup_dir"

echo "All Done!"
