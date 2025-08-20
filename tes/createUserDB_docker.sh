#!/bin/bash

# Root credentials for MariaDB or PostgreSQL inside Docker container
ROOT_USER="root"
ROOT_PASSWORD="root_password"  # This should match the one in your docker-compose.yml

# Prompt user to choose RDBMS
echo "Select the RDBMS:"
echo "1) MariaDB/MySQL (in Docker)"
echo "2) PostgreSQL"
read -p "Enter choice [1 or 2]: " db_choice

# Prompt for configuration
read -p "Enter new database user name: " DB_USER
read -s -p "Enter new database user password: " DB_PASSWORD
echo
read -p "Enter database name to grant access to: " DATABASE_NAME

# For MariaDB/MySQL, prompt for the Docker service name (as in docker-compose.yml)
if [ "$db_choice" -eq 1 ]; then
    read -p "Enter Docker Compose service name for MariaDB (e.g., 'mariadb'): " SERVICE_NAME
fi
echo

# Function to create a MySQL/MariaDB user in Docker container
create_mysql_user() {
    echo "Creating MariaDB/MySQL user and granting privileges inside Docker container..."
    docker exec -i $SERVICE_NAME mysql -u $ROOT_USER -p$ROOT_PASSWORD -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
    docker exec -i $SERVICE_NAME mysql -u $ROOT_USER -p$ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DB_USER'@'%';"
    docker exec -i $SERVICE_NAME mysql -u $ROOT_USER -p$ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
    echo "MariaDB/MySQL user $DB_USER created and granted privileges on $DATABASE_NAME."
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
        echo "Invalid option. Please choose 1 for MariaDB/MySQL or 2 for PostgreSQL."
        exit 1
        ;;
esac    
