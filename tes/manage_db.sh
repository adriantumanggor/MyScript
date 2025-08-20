#!/bin/bash
USER="YOUR_USERNAME"
PASSWORD="YOUR_PASSWORD"

# Function to import SQL file
import_sql() {
  if [ -f "$SQL_FILE" ]; then
    echo "Importing SQL structure from '$SQL_FILE' into '$DB_NAME'..."
    mysql -u $USER -p$PASSWORD $DB_NAME <"$SQL_FILE"
    echo "SQL structure imported successfully."
  else
    echo "Error: SQL file '$SQL_FILE' not found."
    exit 1
  fi
}

# Function to create database
create_db() {
  echo "Creating database '$DB_NAME'..."
  mysql -u $USER -p$PASSWORD -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
  echo "Database '$DB_NAME' created successfully."
}

while true; do
  # Main menu
  echo "Select an action:"
  echo "1) Create a new database and import structure"
  echo "2) Import into an existing database"
  echo "3) Exit"
  read -p "Enter your choice (1, 2, or 3): " ACTION_CHOICE

  case $ACTION_CHOICE in
  1)
    echo "Choose a mode:"
    echo "a) create-first (create the database and then import the SQL structure)"
    echo "b) import-first (import the SQL file to create the database structure directly)"
    read -p "Enter the mode (a or b): " MODE_CHOICE
    case $MODE_CHOICE in
    a)
      read -p "Enter the database name: " DB_NAME
      read -p "Enter the path to the SQL file: " SQL_FILE
      create_db
      import_sql
      ;;
    b)
      read -p "Enter the path to the SQL file: " SQL_FILE
      read -p "Enter the database name: " DB_NAME
      import_sql
      ;;
    *)
      echo "Error: Invalid mode. Choose 'a' or 'b'."
      exit 1
      ;;
    esac
    ;;
  2)
    read -p "Enter the database name: " DB_NAME
    read -p "Enter the path to the SQL file: " SQL_FILE
    import_sql
    ;;
  3)
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo -e "Error: Invalid choice. Use '1', '2', or '3'.\n"
    ;;
  esac
done