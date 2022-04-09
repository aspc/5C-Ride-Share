# Dockerfile, based on Dockerfile of ASPC main site

FROM ruby:2.6.3 AS Core

# Update system packages
RUN apt-get update

# Install sudo to simplify transfer process
RUN apt-get install -y sudo

# Install dependencies
RUN apt-get install -y build-essential git nginx postgresql libpq-dev python-dev libsasl2-dev \
                       libssl-dev libffi-dev gnupg2 curl libjpeg-dev libxml2-dev libxslt-dev npm
RUN gem install bundler
# RUN npm install -g yarn

WORKDIR /claremontrideshare

COPY Gemfile Gemfile.lock /claremontrideshare/
RUN gem install nokogiri -v '1.7.1' -- --use-system-libraries
RUN bundle install
# COPY package.json yarn.lock /claremontrideshare/
# RUN yarn install

EXPOSE 8080

COPY docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
