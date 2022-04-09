#!/bin/bash

FILE=/claremontrideshare/docker/setup_completion_marker

setupDB() {
    echo "Setting up DB"
    bundle exec rake db:create 
    bundle exec rake db:migrate
    touch $FILE 
}

dbIsSetup() {
    if test -f $FILE; then 
    return 0
    else return 1
    fi
}

dbIsSetup && echo "Database is Already Setup!" || setupDB
echo "Setup Complete"





