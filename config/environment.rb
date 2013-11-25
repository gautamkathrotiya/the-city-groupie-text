# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Rcplugin::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => Rcplugin::SMTP_USER,
  :password => Rcplugin::SMTP_PASSWORD,
  :domain => Rcplugin::SMTP_DOMAIN,
  :address => Rcplugin::SMTP_ADDRESS,
  :port => Rcplugin::SMTP_PORT,
  :authentication => :plain,
  :enable_starttls_auto => Rcplugin::SMTP_TLS
}