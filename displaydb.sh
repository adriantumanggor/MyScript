#!/bin/bash

# Database credentials
USER="YOUR_USERNAME"
PASSWORD="YOUR_PASSWORD"


# Prompt the user for the type of query
echo "Select query type:"
echo "1) Display databases"
echo "2) Display database structure"
echo "3) Display table structure"
read -p "Enter your choice (1, 2, or 3): " choice

case $choice in
  1)
    QUERY="SHOW DATABASES;"
    ;;
  2)
    read -p "Enter the database name: " DB
    QUERY="USE $DB; SHOW TABLES;"
    ;;
  3)
    read -p "Enter the database name: " DB
    read -p "Enter the table name: " TABLE
    QUERY="USE $DB; DESCRIBE $TABLE;"
    ;;
  *)
    echo "Invalid choice"
    exit 1
    ;;
esac

# Execute the query and print the output
sudo mysql -u $USER -p$PASSWORD -e "$QUERY"
