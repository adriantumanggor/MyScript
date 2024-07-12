#!/bin/bash

# Function to display the menu
show_menu() {
  echo "Choose an action:"
  echo "1) Create a new database and import SQL structure"
  echo "2) Import SQL file into an existing database"
  echo "3) Exit"
}

# Function to import SQL file
import_sql() {
  if [ -f "$SQL_FILE" ]; then
    echo "Importing SQL structure from '$SQL_FILE' into '$DB_NAME'..."
    mysql -u root -p $DB_NAME < "$SQL_FILE"
    echo "SQL structure imported successfully."
  else
    echo "Error: SQL file '$SQL_FILE' not found."
    exit 1
  fi
}

# Function to create database
create_db() {
  echo "Creating database '$DB_NAME'..."
  mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
  echo "Database '$DB_NAME' created successfully."
}

while true; do
  show_menu
  read -p "Enter your choice: " CHOICE

  case $CHOICE in
    1)
      read -p "Enter the database name: " DB_NAME
      read -p "Enter the SQL file path: " SQL_FILE
      echo "Choose the mode:"
      echo "1) import-first (import the SQL file to create the database structure)"
      echo "2) create-first (create the database and then import the SQL structure)"
      read -p "Enter your choice: " MODE_CHOICE

      if [ "$MODE_CHOICE" == "1" ]; then
        MODE="import-first"
        create_db
        import_sql
      elif [ "$MODE_CHOICE" == "2" ]; then
        MODE="create-first"
        create_db
        import_sql
      else
        echo "Error: Invalid mode. Choose '1' or '2'."
        exit 1
      fi
      ;;
    2)
      read -p "Enter the database name: " DB_NAME
      read -p "Enter the SQL file path: " SQL_FILE
      import_sql
      ;;
    3)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Error: Invalid choice. Choose '1', '2', or '3'."
      ;;
  esac
done
