OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'],
  {
    :client_options => {
      :site => "#{ENV['GITHUB_URL']}/api/v3",
      :authorize_url => "#{ENV['GITHUB_URL']}/login/oauth/authorize",
      :token_url => "#{ENV['GITHUB_URL']}/login/oauth/access_token"
    }
  }
end
