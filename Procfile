web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -c 6 -v -C ./config/sidekiq.yml -e $RAILS_ENV
