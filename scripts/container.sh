#!/bin/bash
# :summary abstraction of native docker commands
# :project Shell Script (2020)
# :author SubArtic15
# :website https://github.com/SubArtic15/Shell-Scripts


if [ `pgrep docker | wc -l` -gt 1 ]; then
  CONTAINER_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/back-end/" >/dev/null 2>&1 && pwd )"


  # display images in the format [REPO]  [TAG]   [IMAGE ID]
  if [ "$1" == "images" ] || [ "$1" == "im" ]; then
    docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}"


  # display current containers in the format []
  elif [ "$1" == "list" ] || [ "$1" == "ls" ]; then
    # check to see if there are any running containers
    if [ `docker container ls | wc -l` -eq "1" ]; then
      printf "\033[1;31mNothing happened, because no container are running\033[0m\n"
    else
      python3 $CONTAINER_DIR/container_list.py
    fi


  # change the name of a given image
  elif [ "$1" == "rename" ] || [ "$1" == "rn" ]; then
    # check if see if proper number of arguments; args=3
    if [ "$@" -ne 3 ]; then
      echo "container rn SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]"
    fi
    docker tag "$2" "$3"
    clear
    container images

  # create N number of container of container type -i and image tag of -t
  elif [ "$1" == "create" ]; then
    python3 $CONTAINER_DIR/container_create.py "${@:2:5}"

  # destroy N number of containers of quantity --number or of name --name
  elif [ "$1" == "kill" ]; then
    python3 $CONTAINER_DIR/container_kill.py "${@:2:5}"


  else
    if [ `pgrep docker | wc -l` -eq "0" ]; then
      printf "\033[1;31mNothing happened, because docker is not running\033[0m\n"
    fi

    printf "\nUsage: container [COMMAND]\n\nAn abstraction to docker commands.\n"
    printf "\nCommands:\n  [image OR im]\t\tdisplay docker images\n"
    printf "  [list OR ls]\t\tdisplay all running docker containers\n"
    printf "  [rename OR rn]\tchange the name of a given docker image\n"
    printf "  [create]\t\tcreate a background docker container\n"
    printf "  [kill]\t\tstop a given number or name of an active container\n\n"
  fi

else
  printf "\033[1;31mNothing happened, because docker is not running\033[0m\n"
fi
