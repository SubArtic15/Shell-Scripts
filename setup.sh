#!/bin/bash



# set env variables
CWD=$(pwd)
MASTER_FILE=~/.cc_scripts

HOST=("splitter.sh" "launch.sh" "container.sh")
GUEST=("splitter.sh")



function add_script {
  # adds the following lines to $MASTER_FILE
  #
  # [SCRIPT_NAME]_path=[CWD]/scipts/[SCRIPT_FILE]
  # alias [SCRIPT_NAME]="source $[SCRIPT_NAME]"
  #

  if [ "$#" -ne 1 ]; then
    echo "[ERROR]: An invalid number of arguments given!"
    return
  fi

  # define local varibales to be loaded later on
  local script_file="$1"
  local script_name=(${script_file//.sh/ })

  # information text
  echo "  └──[SETUP]: Adding $script_file..."

  # add line #1 to $MASTER_FILE
  printf "$script_name" >> $MASTER_FILE
  printf "_path=$CWD/scripts/$script_file\n" >> $MASTER_FILE

  # add line #2 to $MASTER_FILE
  printf "alias $script_name=" >> $MASTER_FILE
  printf '"source $' >> $MASTER_FILE
  printf "$script_name" >> $MASTER_FILE
  printf "_path" >> $MASTER_FILE
  printf '"\n' >> $MASTER_FILE
}



function reset_cc_scripts {
  echo "[SETUP]: a previous scripts file has been identified."
  echo "[SETUP]: resetting previous scripts file."

  rm -f $MASTER_FILE
  touch $MASTER_FILE

  printf "#!/bin/bash\n\n" >> $MASTER_FILE
}


# -------------------------------[ MAIN ]-------------------------------

function main {
  if [ "$#" -ne 1 ]; then
    echo "./setup.sh [HOST|GUEST]"
    return
  fi

  if [ "$1" == "HOST" ]; then
    echo "HOST selected"
    SCRIPTS=${HOST[@]}
  elif [ "$1" == "GUEST" ]; then
    echo "GUEST selected"
    SCRIPTS=${GUEST[@]}
  else
    echo "./setup.sh [HOST|GUEST]"
    return
  fi

  # modify ~/.bash_profile only if it has not been modified
  if grep -Fxq "source ~/.cc_scripts" ~/.bash_profile; then
    echo
  else
    echo "[SETUP]: modifying ~/.bash_profile to include new scripts"
    echo "source ~/.cc_scripts" >> ~/.bash_profile
  fi

  # manage previous compilations
  echo "[SETUP]: checking for existing scripts file..."
  if [[ -f "$MASTER_FILE" ]]; then
    reset_cc_scripts
  fi

  # loop through all scripts and add them, and their dependencies to ~/.bash_profile
  echo "[SETUP]: adding scripts..."
  for srpt in ${SCRIPTS[@]}; do
    add_script $srpt
  done
  echo -e "[SETUP]: all scripts loaded!\n"
  source $MASTER_FILE
}
# -------------------------------[ MAIN ]-------------------------------
main "$@"
