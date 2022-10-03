The source code for version 2 of the 5C Rideshare web application. Created by Brad Bain, Pavle
Rohalj, and Adam Guo. Original version created by Jesse Pollak. Maintained by ASPC.

# Local development

1. Install [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/)
2. Go to your cloned repository: `cd /path/to/5crideshare/`
3. Run `docker-compose up -d`
4. Go to [localhost:3000/5crideshare](localhost:3000/5crideshare)

# Production

5CRideshare is hosted on Peninsula and deployment is managed using Capistrano. To deploy, run
`docker-compose run web bundle exec cap production deploy`.
