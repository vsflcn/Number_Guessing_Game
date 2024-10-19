#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

MAIN_PROGRAM() {
  echo -e "\nEnter your username:"
  read USER_NAME

  if [[ -z $USER_NAME ]]
  then 
    # if no such user it adds to database
    USER_NAME=$(echo $($PSQL ""))
  fi
}



MAIN_PROGRAM