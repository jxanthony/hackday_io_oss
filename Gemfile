source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '3.2.17'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'thin'
gem 'unicorn'
gem 'haml'
gem 'bootstrap-sass'
gem 'rails-timeago'
gem "rails_config"

group :production do
  gem "pg"
  gem "newrelic_rpm"
  gem "rails_12factor"
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass', "~> 3.2.5" # FIX: set to previous version to avoid heroku warnings
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'omniauth'
gem 'omniauth-yammer'
gem 'omniauth-github'

group :development, :test do
  gem 'debugger' 
  gem 'sqlite3'

  gem 'rspec-rails'
  gem 'annotate'
  gem 'simplecov'
end

group :test do
  gem 'fabrication'
  gem 'rspec'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'database_cleaner'
end
