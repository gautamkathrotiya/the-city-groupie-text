#This file loads the configuration, please don't edit the configuration here, but instead use
# /config/configuration.yml

#Initialize Configurations
raw_config = File.read("#{Rails.root}/config/configuration.yml")
APP_CONFIG = YAML.load(raw_config)

module Rcplugin
  DEV_ENV = APP_CONFIG[Rails.env]["DEV_ENV"]
  THE_CITY_SECRET = APP_CONFIG[Rails.env]["THE_CITY_SECRET"]
  THE_CITY_APP_ID = APP_CONFIG[Rails.env]["THE_CITY_APP_ID"]

  TWILIO_ACCOUNT = APP_CONFIG[Rails.env]["TWILIO_ACCOUNT"]
  TWILIO_TOKENID = APP_CONFIG[Rails.env]["TWILIO_TOKENID"]
  TWILIO_FROM_NUMBER = APP_CONFIG[Rails.env]["TWILIO_FROM_NUMBER"]

  CITY_ADMIN_SECRET = APP_CONFIG[Rails.env]["CITY_ADMIN_SECRET"]
  CITY_USER_TOKEN = APP_CONFIG[Rails.env]["CITY_USER_TOKEN"]

  SMTP_USER = APP_CONFIG[Rails.env]["SMTP_USER"]
  SMTP_PASSWORD = APP_CONFIG[Rails.env]["SMTP_PASSWORD"]
  SMTP_DOMAIN = APP_CONFIG[Rails.env]["SMTP_DOMAIN"]
  SMTP_ADDRESS = APP_CONFIG[Rails.env]["SMTP_ADDRESS"]
  SMTP_FROM = APP_CONFIG[Rails.env]["SMTP_FROM"]
  SMTP_PORT = APP_CONFIG[Rails.env]["SMTP_PORT"]
  SMTP_TLS = APP_CONFIG[Rails.env]["SMTP_TLS"]
end