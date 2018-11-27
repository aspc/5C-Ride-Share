# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# install_plugin Capistrano::SCM::Hg
# or
# require "capistrano/scm/svn"
# install_plugin Capistrano::SCM::Svn
# or
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Include tasks from other gems included in your Gemfile

# RVM compatibility
require "capistrano/rvm"

# Load Rails plugins
require "capistrano/rails"
require "capistrano/puma"

install_plugin Capistrano::Puma  # Default puma tasks

# Execute rake tasks remotely
require "capistrano/rake"