source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '~>4.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'thin'
gem 'unicorn'
gem 'haml'
gem 'bootstrap-sass'
gem 'rails-timeago'
gem "rails_config"
gem 'sunspot_rails'
gem 'sunspot_solr'
gem 'acts-as-taggable-on'
gem 'rails4_upgrade'
gem 'rails4-autocomplete'
gem 'turbolinks'

group :production do
  gem "pg"
  gem "newrelic_rpm"
  gem "rails_12factor"
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass' # FIX: set to previous version to avoid heroku warnings
  gem 'sass-rails', '~>4.0.0'
  gem 'coffee-rails', '~>4.0.0'
  gem 'uglifier', '>=1.3.0'
end

gem 'jquery-rails'
gem 'select2-rails'
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.0.0'

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
  #gem 'capybara-webkit'
  gem 'database_cleaner'
end

#update rails4 gems
# Gemfile
gem 'actionpack-action_caching', '~>1.0.0'
gem 'actionpack-page_caching', '~>1.0.0'
gem 'actionpack-xml_parser', '~>1.0.0'
gem 'actionview-encoded_mail_to', '~>1.0.4'
gem 'activerecord-session_store', '~>0.0.1'
gem 'activeresource', '~>4.0.0.beta1'
gem 'protected_attributes', '~>1.0.1'
gem 'rails-observers', '~>0.1.1'
gem 'rails-perftest', '~>0.0.2'
