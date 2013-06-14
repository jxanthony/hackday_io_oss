# Load the rails application
require File.expand_path('../application', __FILE__)

require 'rubygems'
require 'net/https'
require 'json'
require 'uri'
require 'pp'


CONNECTION             = Net::HTTP.new('yammer.com', 443)
CONNECTION.use_ssl     = true
#CONNECTION.verify_mode = OpenSSL::SSL::VERIFY_NONE
HEADERS                = {"Authorization" => "Bearer: mAZwF29JyoCQVRRD67QqXg"}

# Initialize the rails application
Hackday::Application.initialize!
