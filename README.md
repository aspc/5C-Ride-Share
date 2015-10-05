The source code for the Pomona Shuttle Share application. Created by Jesse Pollak, maintained by ASPC.

# Local development #

1. [Install rvm](https://rvm.io/)
2. Install ruby 2.0.0: `rvm install ruby-2.0.0-p643`
3. Go to your cloned repository: `cd /path/to/5crideshare/`
4. Install bundler: `gem install bundler`
5. Install dependencies: `bundle install`
6. Run the migrations for develop: `bundle exec rake db:migrate`
7. Run the migrations for the tests: `RAILS_ENV=test bundle exec rake db:migrate`
8. Run the limited tests that we have: `bundle exec rspec spec/`
9. Start the server with rack: `bundle exec rackup`
10. Navigate to appropriate port on your browser: `http://localhost:9292`

# Production #

5CRideshare is hosted on Heroku. Fortunately the gems always seem to compile there correctly, so there is no manual configuration to do on that front! As of May 2015, the app is deployed on the Cedar-14 stack, using Ruby 2.0.0 and Rails 3.2.11. A legacy version of the app still exists on the Bamboo stack, but has been deprecated. All traffic to `5crideshare.com` is now configured to point to the new Cedar-14 infrastructure. The Heroku appname is `fivecrideshare-cedar` and is owned by Matt Dahl.

To deploy:

1. Set up your git remotes: `git remote add heroku-cedar git@heroku.com:fivecrideshare-cedar.git`
2. Push: `git push heroku-cedar master`
3. Compile the static assets if you need to: `heroku run rake assets:precompile --app fivecrideshare-cedar`

Heroku provides a free Postgres database hosted on EC2 that we use. You can manage that by logging into the Heroku dashboard online, or using the standard CLI with the connection details found on the dashboard.

ASPC manages the DNS records for this site too, unlike those of Peninsula which ITS takes care of.