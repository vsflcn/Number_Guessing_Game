#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess_game -t --no-align -c"

echo "Enter your username:"
read USERNAME

RANDOM() {
  RANDOM_NUMBER=$((1 + $RANDOM % 1000))
  echo $RANDOM_NUMBER
}

MAIN_PROGRAM() {
  
  SECRET_NUMBER=$(RANDOM)
  echo $SECRET_NUMBER

  USER_RESULT=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

  if [[ -z $USER_RESULT ]]; then 
    INSERT_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
    USER_RESULT=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
    echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
  else
    GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=$USER_RESULT")
    BEST_GAME=$($PSQL "SELECT MIN(number_of_guesses) FROM games WHERE user_id=$USER_RESULT")
    echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took ${BEST_GAME:-0} guesses."
  fi

  echo -e "\nGuess the secret number between 1 and 1000:"

  NUMBER_OF_GUESSES=0
  
  while true; do
    read SELECTED_NUMBER

    if ! [[ $SELECTED_NUMBER =~ ^[0-9]+$ ]]; then
      echo "That is not an integer, guess again:"
      continue
    fi

    ((NUMBER_OF_GUESSES++))

    if [[ $SELECTED_NUMBER -gt $SECRET_NUMBER ]]; then 
      echo -e "\nIt's lower than that, guess again:"
    elif [[ $SELECTED_NUMBER -lt $SECRET_NUMBER ]]; then
      echo -e "\nIt's higher than that, guess again:"
    else
      echo -e "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
      INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(secret_number, number_of_guesses, user_id) VALUES($SECRET_NUMBER, $NUMBER_OF_GUESSES, $USER_RESULT)")
      break
    fi
  done
}

MAIN_PROGRAM