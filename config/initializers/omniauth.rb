OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, CONFIG['facebook_key'], CONFIG['facebook_secret'],
    :scope => "email, friends_birthday"
end
