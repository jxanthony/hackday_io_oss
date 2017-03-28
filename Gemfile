source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '~>4.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pry-nav', '= 0.2.4'
gem 'puma', '= 2.11.3'
gem 'haml', '= 4.0.5'
gem 'bootstrap-sass', '= 3.1.1.0'
gem 'rails-timeago', '= 2.10.0'
gem "rails_config", '= 0.3.3'
gem 'sunspot_rails', '= 2.1.1'
gem 'sunspot_solr', '= 2.1.1'
gem 'acts-as-taggable-on', '= 3.2.6'
gem 'rails4_upgrade', '= 0.5.0'
gem 'rails4-autocomplete', '= 1.1.0'
gem 'turbolinks', '= 2.2.2'
gem 'rake', '< 11.0'


group :production do
  gem "pg", '= 0.17.1'
  gem "newrelic_rpm", '= 3.7.3.204'
  gem "rails_12factor", '= 0.0.2'
  gem "figaro", '= 1.1.1'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass', '= 3.2.18' # FIX: set to previous version to avoid heroku warnings
  gem 'sass-rails', '~>4.0.0'
  gem 'coffee-rails', '~>4.0.0'
  gem 'uglifier', '>=1.3.0'
end

gem 'jquery-rails', '= 3.1.0'
gem 'select2-rails', '= 3.5.9.3'
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.0.0'

gem 'omniauth', '= 1.2.1'
gem 'omniauth-github', '= 1.1.1'

group :development, :test do
  gem 'debugger', '= 1.6.8'
  gem 'sqlite3', '1.3.9'
  gem 'dotenv-rails', '= 2.0.2'
  gem 'rspec-rails', '= 2.14.2'
  gem 'annotate', '= 2.6.2'
  gem 'simplecov', '= 0.8.2'
end

group :test do
  gem 'fabrication', '= 2.9.8'
  gem 'rspec', '= 2.14.1'
  gem 'shoulda-matchers', '= 2.5.0'
  gem 'capybara', '= 2.4.4'
  #gem 'capybara-webkit'
  gem 'database_cleaner', '= 1.2.0'
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
