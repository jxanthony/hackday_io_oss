# Load the rails application
require File.expand_path('../application', __FILE__)

require 'rubygems'
require 'net/https'
require 'json'
require 'uri'
require 'pp'
require 'yammer'
require 'yaml'

APP_CONFIG = YAML.load_file("#{Rails.root}/config/app_config.yml")

YAMMER = Yammer::Client.new(
  :client_id     => APP_CONFIG['YMR_CLIENT_ID'],
  :client_secret => APP_CONFIG['YMR_CLIENT_SECRET'],
  :access_token  => APP_CONFIG['ACCESS_TOKEN']
)

CONNECTION             = Net::HTTP.new('yammer.com', 443)
CONNECTION.use_ssl     = true

# Initialize the rails application
Hackday::Application.initialize!
