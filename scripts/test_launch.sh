#!/bin/bash
# :summary a shortcut system ot change directories
# :project Shell Script (2020)
# :author SubArtic15
# :website https://github.com/SubArtic15/Shell-Scripts

BACK_END_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/back-end/" >/dev/null 2>&1 && pwd )"


# do config actions either add or remove variables
if [ "$1" == "--add" ] || [ "$1" == "--remove" ]; then
  python3 $BACK_END_DIR/launch_config.py "$BACK_END_DIR" "$@"


# display help menu
elif [ "$1" == "--help" ] || [ "$1" == '-h' ] || [ "$#" -eq 0 ]; then
  while IFS='' read -r line; do
    printf "\033[1;36mShorcut\033[0m: $line\n"
    printf "\033[1;35mDescription\033[0m: $(jq ".$line.desc" -r $BACK_END_DIR/launch_paths.json)\n"
    printf "\033[1;32mPath\033[0m: $(jq ".$line.path" -r $BACK_END_DIR/launch_paths.json)\n\n"
  done < <(jq 'keys[]' $BACK_END_DIR/launch_paths.json)


# check to see if a given key exists
elif [ `jq ".$1" back-end/launch_paths.json | wc -l` -ne '4' ]; then
  printf "\33[1;31mNo shortcut by the name of \033[0m '$1' \033[1;31m exists right now\033[0m\n"


# given that the provided shorcut exists then go to it
elif [ "$#" -eq 1 ]; then
  new_path=`jq ".$1.path" -r $BACK_END_DIR/launch_paths.json`
  cd "$new_path"
  clear
fi
