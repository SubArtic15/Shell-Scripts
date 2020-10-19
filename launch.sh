#!/bin/bash


LaunchCodes=("nsa" "captcha" "nau" "python" "webserver" "storm" "kapu" "freq" "c"
             "cap" "cymod" "site" "gore" "git")


command clear
if [ "$1" == "nsa" ]; then
  cd "/Users/CyrusLane/Documents/ProgrammingProjects/CAE-CO 2019" || return

elif [ "$1" == "captcha" ] || [ "$1" == "cap" ]; then
  cd "/Users/CyrusLane/Documents/ProgrammingProjects/Project Captcha" || return

elif [ "$1" == "nau" ]; then
  cd "/Users/CyrusLane/Documents/NAU/FALL 2020" || return

elif [ "$1" == "storm" ]; then
  cd "/Users/CyrusLane/Documents/NAU/FALL 2019/CS 485" || return

elif [ "$1" == "kapu" ]; then
  cd "/Users/CyrusLane/Documents/ProgrammingProjects/Kapu Obfuscation" || return

elif [ "$1" == "freq" ]; then
  cd "/Users/CyrusLane/Documents/ProgrammingProjects/Frequency Hopper" || return

elif [ "$1" == "python" ]; then

  if [ "$2" == "site-packages" ]; then
    cd "/usr/local/lib/python3.8/site-packages" || return
  else
     cd "/Users/CyrusLane/Documents/ProgrammingProjects/Simple Python Programs" || return
  fi

elif [ "$1" == "c" ] || [ "$1" == "C" ]; then
  cd "/Users/CyrusLane/Documents/ProgrammingProjects/Small C Programs" || return

elif [ "$1" == "hub" ]; then
  cd "/Users/CyrusLane/Documents/ProgrammingProjects" || return
  command ls -G

elif [ "$1" == "webserver" ]; then
  cd "$HOME" || return
  command ./StartServer

elif [ "$1" == "site" ]; then
  cd "/Users/CyrusLane/Documents/ProgrammingProjects/Personal-Website" || return

elif [ "$1" == "cymod" ] || [ "$1" == "mod" ]; then
  cd "/Library/Frameworks/Python.framework/Versions/3.8/lib/python3.8/site-packages/cymod" || return

elif [ "$1" == "gore" ]; then
  cd "/Users/CyrusLane/Documents/Gore Internship" || return

elif [ "$1" == "git" ]; then
  cd "/Users/CyrusLane/Documents/ProgrammingProjects/GitRepositories" || return

else
  echo "< INPUT_ERROR >"
  for tag in "${LaunchCodes[@]}"
  do
    echo "- launch $tag"
  done
fi
