#!/bin.bash

ContainerCodes=("images" "list" "ls" "create" "kill")


if [ "$1" == "images" ]; then
  docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}"

elif [ "$1" == "list" ] || [ "$1" == "ls" ]; then
  WorkingDir=$(pwd)
  cd "/Users/CyrusLane/Documents/ProgrammingProjects/Docker" || return
  python3 ContainerManagmentScipt.py ls
  cd "$WorkingDir" || return

elif [ "$1" == "rn" ]; then
  command docker tag "$2" "$3"
  command clear
  container images

elif [ "$1" == "create" ] || [ "$1" == "kill" ]; then
  WorkingDir=$(pwd)
  cd "/Users/CyrusLane/Documents/ProgrammingProjects/Docker" || return
  python3 ContainerManagmentScipt.py "$@"
  cd "$WorkingDir" || return

else
  echo "< INPUT_ERROR >"
  for tag_ in "${ContainerCodes[@]}"
  do
    echo "- container $tag_"
  done
fi
