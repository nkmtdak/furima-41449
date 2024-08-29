#!/usr/bin/env bash
# exit on error
set -o errexit

# Build commands
bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean

# Database setup (choose one of the following options)
# Option 1: Reset and load schema
bundle exec rake db:drop db:create db:schema:load

# Option 2: Conditional migration
# bundle exec rake db:migrate:status | grep -q "down" && bundle exec rake db:migrate || echo "No migrations to run"

# Option 3: Full database setup
# bundle exec rake db:setup

# Additional commands if needed
# bundle exec rake db:seed