The source code for the Pomona Shuttle Share application. Created by Jesse Pollak, maintained by ASPC.

# Local development #
On OSX Yosemite:

1. Master should be in a stable enough state to run locally: `git co master`
2. Start Postgres: `postgres -D /usr/local/var/postgres`
3. Start the server with rack: `rackup`

# Prod #
5CRideshare is hosted on Heroku. As of May 2015, it is deployed on the Cedar-14 stack, using Ruby 2.0.0 and Rails 3.2.11. A legacy version of the app still exists on the Bamboo stack, but has been deprecated. All traffic to `5crideshare.com` is now configured to point to the new Cedar-14 infrastructure. The Heroku appname is `fivecrideshare-cedar` and is owned by Matt Dahl.

To deploy:

1. Set up your git remotes: `git remote add heroku-cedar git@heroku.com:fivecrideshare-cedar.git`
2. Push: `git push heroku-cedar master`
3. Compile the static assets if you need to: `heroku run rake assets:precompile --app fivecrideshare-cedar`

Heroku provides a free Postgres database hosted on EC2 that we use. You can manage that by logging into the Heroku dashboard online, or using the standard CLI with the connection details found on the dashboard.

ASPC manages the DNS records for this site too, unlike those of Peninsula which ITS takes care of.