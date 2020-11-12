#!/bin/bash
# :summary a shortcut system ot change directories
# :project Shell Script (2020)

BACK_END_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/back-end/" >/dev/null 2>&1 && pwd )"
SCRIPT_PATH="$HOME/.launch_paths.json"


# do config actions either add or remove variables
if [ "$1" == "--add" ] || [ "$1" == "--remove" ]; then
  python3 $BACK_END_DIR/launch_config.py "$BACK_END_DIR" "$@"


# display help menu
elif [ "$1" == "--help" ] || [ "$1" == '-h' ] || [ "$#" -eq 0 ]; then
  printf "\nUsage: launch [COMMAND]\n\nA favorites based directory system.\n"
  printf "\nCommands:\n  [--add] [shortcut] [path]\t\tadd a new shortcut to system.\n"
  printf "  [--remove] [shortcut]\t\tremoves an existing shortcut.\n"
  printf "  [shortcut] change directory to path associated with a given shortcut.\n\n\n"
  printf "EXISTING SHORTCUTS\n-----------------------------------------------\n"

  while IFS='' read -r line; do
    printf "\033[1;36mShorcut\033[0m: $line\n"
    printf "\033[1;35mDescription\033[0m: $(jq ".$line.desc" -r $SCRIPT_PATH)\n"
    printf "\033[1;32mPath\033[0m: $(jq ".$line.path" -r $SCRIPT_PATH)\n\n"
  done < <(jq 'keys[]' $SCRIPT_PATH)


# check to see if a given key exists
elif [ `jq ".$1" $SCRIPT_PATH | wc -l` -ne '4' ]; then
  printf "\33[1;31mNo shortcut by the name of \033[0m '$1' \033[1;31m exists right now\033[0m\n"


# given that the provided shorcut exists then go to it
elif [ "$#" -eq 1 ]; then
  new_path=`jq ".$1.path" -r $SCRIPT_PATH`
  cd "$new_path"
  clear
fi
