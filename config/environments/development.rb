Hacktracker::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false


  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
end

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:yammer] = {
  provider: 'yammer',
  uid: '1',
  info: {
    name: 'Doge',
    image: 'http://img2.wikia.nocookie.net/__cb20141105223610/r2d/images/7/73/Dogepic.png',
    email: 'doge@wow.com'
  },
  extra: { raw_info: { network_id: '1' } },
  credentials: { token: 'some_token' }
}