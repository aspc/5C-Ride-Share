#!/bin/bash

echo "Setting up DB"
bundle exec rake db:create 
bundle exec rake db:migrate
echo "Setup Complete"
