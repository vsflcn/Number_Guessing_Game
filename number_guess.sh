#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

MAIN_PROGRAM() {
  echo -e "\nEnter your username:"
  read USERNAME

  if [[ -z $USERNAME ]]
  then 
    USERNAME=$(echo $($PSQL ""))
  fi
}



MAIN_PROGRAM