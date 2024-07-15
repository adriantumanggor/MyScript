#!/bin/bash

# Database credentials
USER="YOUR_USERNAME"
PASSWORD="YOUR_PASSWORD"

while true; do
  # Display databases
  QUERY="SHOW DATABASES;"
  sudo mysql -u $USER -p$PASSWORD -e "$QUERY"
  
  # Display the main menu
  echo "Select query type:"
  echo "1) Display database structure"
  echo "2) Display table structure"
  echo "3) Exit"
  read -p "Enter your choice (1, 2, or 3): " choice

  case $choice in
  1)
    # Display database structure
    read -p "Enter the database name: " DB
    QUERY="USE $DB; SHOW TABLES;"
    sudo mysql -u $USER -p$PASSWORD -e "$QUERY"
    ;;
  2)
    # Display table structure
    read -p "Enter the database name: " DB
    while true; do
      QUERY="USE $DB; SHOW TABLES;"
      sudo mysql -u $USER -p$PASSWORD -e "$QUERY"
      
      echo "1) Display table contents"
      echo "2) Back to previous menu"
      read -p "Enter your choice (1 or 2): " sub_choice
      
      case $sub_choice in
      1)
        read -p "Enter the table name: " TABLE
        QUERY="USE $DB; SELECT * FROM $TABLE;"
        sudo mysql -u $USER -p$PASSWORD -e "$QUERY"
        ;;
      2)
        break
        ;;
      *)
        echo "Invalid choice"
        ;;
      esac
    done
    ;;
  3)
    # Exit the script
    echo "Exiting..."
    exit 0
    ;;
  *)
    echo "Invalid choice"
    ;;
  esac
done
