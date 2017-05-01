The source code for the Pomona Shuttle Share application. Created by Jesse Pollak, maintained by ASPC.

# Local development #

1. [Install rvm](https://rvm.io/)
2. Install ruby 2.4.1: `rvm install ruby-2.4.1`
3. Go to your cloned repository: `cd /path/to/5crideshare/`
4. Install bundler: `gem install bundler`
5. Install dependencies: `bundle install`
6. Run the migrations for develop: `bundle exec rake db:migrate`
7. Start the server with rails on localhost: `rails s -b 127.0.0.1`

# Tests #

1. Run the migrations for the tests: `RAILS_ENV=test bundle exec rake db:migrate`
2. Run the limited tests that we have: `bundle exec rspec spec/`

# Production #

5CRideshare is hosted on Heroku. As of May 2017, the app is deployed on the Cedar-14 stack, using Ruby 2.4.1 and Rails 4. A legacy version of the app still exists on the Bamboo stack, but has been deprecated. All traffic to `5crideshare.com` is now configured to point to the new Cedar-14 infrastructure. The Heroku appname is `fivecrideshare-cedar` and is owned by Matt Dahl.

To deploy:

1. Set up your git remotes: `git remote add heroku-cedar git@heroku.com:fivecrideshare-cedar.git`
2. Push: `git push heroku-cedar master`
3. Compile the static assets if you need to: `heroku run rake assets:precompile --app fivecrideshare-cedar`

Heroku provides a free Postgres database hosted on EC2 that we use. You can manage that by logging into the Heroku dashboard online, or using the standard CLI with the connection details found on the dashboard.

ASPC manages the DNS records for this site too, unlike those of Peninsula which ITS takes care of.
