#!bin/bash



# set env variables
PWD=$(pwd)
SCRIPTS=("splitter.sh" "launch.sh" "container.sh")



function add_script {
  if [ "$#" -ne 1 ]; then
    echo "[ERROR]: An invalid number of arguments given!"
    return
  fi

  local script_file="$1"
  local script_name=(${script_file//.sh/ })

  # information text
  echo "  └──[SETUP]: Adding $script_file..."

  printf "$script_name" >> ~/.bash_profile
  printf "_path=$PWD/$script_file\n" >> ~/.bash_profile

  printf "alias $script_name=" >> ~/.bash_profile
  printf '"source $' >> ~/.bash_profile
  printf "$script_name" >> ~/.bash_profile
  printf "_path" >> ~/.bash_profile
  printf '"\n' >> ~/.bash_profile
}



# loop through all scripts and add them, and their dependencies to ~/.bash_profile
echo "[SETUP]: adding scripts..."
for srpt in ${SCRIPTS[@]}; do
  add_script $srpt
done
echo -e "[SETUP]: all scripts loaded!\n"
source ~/.bash_profile
