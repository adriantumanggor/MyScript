#!/bin/bash

# Root MySQL user credentials
ROOT_USER="root"
ROOT_PASSWORD="yourrootpassword"

# Prompt user to choose RDBMS
echo "Select the RDBMS:"
echo "1) MySQL"
echo "2) PostgreSQL"
read -p "Enter choice [1 or 2]: " db_choice

# Prompt for configuration
read -p "Enter new database user name: " DB_USER
read -s -p "Enter new database user password: " DB_PASSWORD
echo
read -p "Enter database name to grant access to: " DATABASE_NAME

echo

# Function to create a MySQL user
create_mysql_user() {
    echo "Creating MySQL user and granting privileges..."
    mysql -u $ROOT_USER -p$ROOT_PASSWORD -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
    mysql -u $ROOT_USER -p$ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DB_USER'@'localhost';"
    mysql -u $ROOT_USER -p$ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
    echo "MySQL user $DB_USER created and granted privileges on $DATABASE_NAME."
}

# Function to create a PostgreSQL user
create_postgresql_user() {
    echo "Creating PostgreSQL user and granting privileges..."
    PGPASSWORD=$ROOT_PASSWORD psql -U $ROOT_USER -d $DATABASE_NAME -c "CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';"
    PGPASSWORD=$ROOT_PASSWORD psql -U $ROOT_USER -d $DATABASE_NAME -c "GRANT ALL PRIVILEGES ON DATABASE $DATABASE_NAME TO $DB_USER;"
    echo "PostgreSQL user $DB_USER created and granted privileges on $DATABASE_NAME."
}

# Execute based on user selection
case $db_choice in
1)
    create_mysql_user
    ;;
2)
    create_postgresql_user
    ;;
*)
    echo "Invalid option. Please choose 1 for MySQL or 2 for PostgreSQL."
    exit 1
    ;;
esac
