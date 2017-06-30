OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'],
  {
    :scope => "user",
    :provider_ignores_state => true,
    :client_options => {
      :site => "#{ENV['GITHUB_API_URL']}",
      :authorize_url => "#{ENV['GITHUB_URL']}/login/oauth/authorize",
      :token_url => "#{ENV['GITHUB_URL']}/login/oauth/access_token"
    }
  }
end
