Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, ENV['OMNIAUTH_LINKEDIN_KEY'], ENV['OMNIAUTH_LINKEDIN_SECRET']
end
