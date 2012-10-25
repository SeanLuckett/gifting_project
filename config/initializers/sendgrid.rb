SENDGRID_CONFIG = YAML::load(File.open(File.join(Rails.root, "/config/sendgrid.yml")))[Rails.env]

ActionMailer::Base.smtp_settings = {
  :user_name => SENDGRID_CONFIG["user_name"],
  :password => SENDGRID_CONFIG["password"],
  :domain => SENDGRID_CONFIG["domain"],
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
