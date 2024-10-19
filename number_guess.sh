#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess_game -t --no-align -c"

RANDOM() {
  RANDOM_NUMBER=$((1 + $RANDOM % + 1000))
  echo $RANDOM_NUMBER
}
RANDOM


MAIN_PROGRAM() {
  echo -e "\nEnter your username:"
  read USERNAME

  USERNAME=$(echo $($PSQL "SELECT username FROM users"))

  # if there is no such a user -> add to db
  if [[ -z $USERNAME ]]
  then 
    USERNAME=$(echo $($PSQL "INSERT INTO users(username) VALUES('$USERNAME')"))
    echo -e "\n Welcome, '$USERNAME'! It looks like this is your first time here."
    echo -e "\n Guess the secret number between 1 and 1000:" | while read SELECTED_NUMBER
    do 
      echo -e "\n$SELECTED_NUMBER"

      if [[ $SELECTED_NUMBER -gt $RANDOM_NUMBER ]]
      then 
        echo -e "\nIt's higher than that, guess again:"
        read $SELECTED_NUMBER
      fi

      if [[ $SELECTED_NUMBER -lt $RANDOM_NUMBER ]]
      then 
        echo -e "\nIt's lower than that, guess again:"
        read $SELECTED_NUMBER
      fi

      # if not integer 
      if [[ ! $SELECTED_NUMBER ~= ^[0-9]$ ]]
      then 
        echo -e "\n That is not an integer, guess again: " 
        read $SELECTED_NUMBER
      else

      fi
    done  

  fi

  if [[ $USERNAME ]]
  then
    echo -e "\nWelcome back, $USERNAME>! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  fi
}




MAIN_PROGRAM