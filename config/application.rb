require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Rcplugin

  #The if statement belows checks to see if the environmental variable 'RAILS_ENV' is set to development
  #If it IS set, is uses the first set of credentials. If NOT set it uses the second set

  #Development creds & keys
  if ENV['RAILS_ENV'] == 'development'
    puts 'CTDEBUG: In development environment'

    DEV_ENV = true
    THE_CITY_SECRET = 'YOUR DEV CITY SECRET HERE'
    THE_CITY_APP_ID = 'YOUR DEV CITY APP ID HERE'

    TWILIO_ACCOUNT = 'YOUR DEV TWILIO ACCOUNT HERE'
    TWILIO_TOKENID = 'YOUR DEV TWILIO TOKEN ID HERE'
    TWILIO_FROM_NUMBER = 'YOUR DEV TWILIO FROM NUMBER HERE'

    CITY_ADMIN_SECRET = 'YOUR DEV CITY ADMIN SECRET HERE'
    CITY_USER_TOKEN = 'YOUR DEV CITY USER TOKEN HERE'

    SMTP_USER = 'YOUR DEV SMTP USER HERE'
    SMTP_PASSWORD = 'YOUR DEV SMTP PASSWORD HERE'
    SMTP_DOMAIN = 'YOUR DEV SMTP DOMAIN HERE'
    SMTP_ADDRESS = 'YOUR DEV SMTP ADDRESS HERE'
    SMTP_FROM = 'YOUR DEV SMTP FROM HERE'
    SMTP_PORT = 587 #CHANGE AS NEEDED
    SMTP_TLS = true #Change as needed
  else
    #Production creds & keys
    puts 'CTDEBUG: In production environment'

    DEV_ENV = false
    THE_CITY_SECRET = 'YOUR PRODUCTION CITY SECRET HERE'
    THE_CITY_APP_ID = 'YOUR PRODUCTION CITY APP ID HERE'

    TWILIO_ACCOUNT = 'YOUR PRODUCTION TWILIO ACCOUNT HERE'
    TWILIO_TOKENID = 'YOUR PRODUCTION TWILIO TOKENID HERE'
    TWILIO_FROM_NUMBER = 'YOUR PRODUCTION TWILIO FROM NUMBER HERE'

    CITY_ADMIN_SECRET = 'YOUR PRODUCTION CITY ADMIN SECRET HERE'
    CITY_USER_TOKEN = 'YOUR PRODUCTION CITY USER TOKEN HERE'

    SMTP_USER = 'YOUR PRODUCTION SMTP USER HERE'
    SMTP_PASSWORD = 'YOUR PRODUCTION SMTP PASSWORD HERE'
    SMTP_DOMAIN = 'YOUR PRODUCTION SMTP DOMAIN HERE'
    SMTP_ADDRESS = 'YOUR PRODUCTION SMTP ADDRESS HERE'
    SMTP_FROM = 'YOUR PRODUCTION SMTP FROM HERE'
    SMTP_PORT = 587 #CHANGE AS NEEDED
    SMTP_TLS = true #Change as needed
  end

  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
  end
end