require 'cucumber/rails'
#require "capybara"
#require "capybara/cucumber"
require "capybara/rails"
require 'capybara/poltergeist'
require 'database_cleaner'


# https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2
Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(
      app,
      window_size: [1280, 1024]#,
      #debug:       true
    )
  end

Capybara.default_driver    = :poltergeist
Capybara.javascript_driver = :poltergeist
#Capybara.default_driver    = :selenium

Capybara.server_port = 8080
Capybara.server_host = 'localhost'


DatabaseCleaner.strategy = :truncation

# then, whenever you need to clean the DB
DatabaseCleaner.clean