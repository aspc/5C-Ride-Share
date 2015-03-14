The source code for the Pomona Shuttle Share application. Created by Jesse Pollak, maintained by ASPC.

# Local development #
Bundler sucks! I had to jump through a lot of hoops to get the gems defined in Gemfile.lock to properly build on a local machine running OSX Yosemite. To save other people such trouble in the future, I saved the built gems in the `/vendor` directory, which Rails knows to check first instead of using system gems. If necessary, you can update these using the `bundle install --path vendor/bundle` command, but they should be in a state that is stable to run the app locally as long as no new gems are added.

Those compiled gems are in the `.gitignore` on all branches except `local_dev`. `local_dev` is a branch that should always be kept rebased against master, save the extra commits I made to get the app running locally. To run the app:

1. Checkout out that branch: `git co local_dev`
2. Start Postgres: `postgres -D /usr/local/var/postgres`
3. Start the server with rack: `rackup`

Once you have the gems in the `/vendor` folder, you should be able to checkout `master` or another feature branch and do development there. Then just commit like usual, making sure to rebase `local_dev` against the tip of `master`.


# Prod #
5CRideshare is hosted on Heroku. Fortunately the gems always seem to compile there correctly, so there is no manual configuration to do on that front! As of May 2015, the app is deployed on the Cedar-14 stack, using Ruby 2.0.0 and Rails 3.2.11. A legacy version of the app still exists on the Bamboo stack, but has been deprecated. All traffic to `5crideshare.com` is now configured to point to the new Cedar-14 infrastructure. The Heroku appname is `fivecrideshare-cedar` and is owned by Matt Dahl.

To deploy:

1. Set up your git remotes: `git remote add heroku-cedar git@heroku.com:fivecrideshare-cedar.git`
2. Push: `git push heroku-cedar master`
3. Compile the static assets if you need to: `heroku run rake assets:precompile --app fivecrideshare-cedar`

Heroku provides a free Postgres database hosted on EC2 that we use. You can manage that by logging into the Heroku dashboard online, or using the standard CLI with the connection details found on the dashboard.

ASPC manages the DNS records for this site too, unlike those of Peninsula which ITS takes care of.