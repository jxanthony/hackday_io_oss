source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'thin'
gem 'yammer-client'
gem 'will_paginate'
gem 'unicorn'
gem 'haml'
gem 'bootstrap-sass'

group :production do
  gem "pg"
  gem "newrelic_rpm"
  gem "rails_12factor"
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-yammer'

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
