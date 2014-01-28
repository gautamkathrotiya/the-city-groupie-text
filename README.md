City Groupie Text
=====================

Plugin to allow group managers/leaders to send out texts from The City, written in Ruby.

##Usage##

Open up application.rb and replace all the following lines with your own information from The City:

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
    
You will need to create a new app in The City, as well as generating API keys for a User Admin to get the value for above. Contact The City help for support on this :-)

Next, open up app/assets/javascripts/citytexting.js

    TheCity.PluginHelper.resizeIFrame({
      subdomain: 'CHANGE TO YOUR CITY SUBDOMAIN',    //Change this to your City subdomain
      useSSL: true,       //Whether or not your plugin uses SSL
      extra: 450,           //Extra number of pixels to expand iFrame height to
      refresh: 0        //How often to check for new documentHeight, 0 to disable
    });

and replace the second line with **your** City subdomain.

##Requirements##

###Accounts###
Obviously you need a City account, including a User Admin. You will also need a [Twilio account](http://www.twilio.com) as well as an SMTP account (for failed notifications).

###Gems Required###
+ sass-rails ~> 3.2.3
+ coffee-rails ~> 3.2.1
+ therubyracer
+ uglifier >= 1.0.3
+ execjs 
+ jquery-rails
+ thecity
+ twilio-ruby
+ sendgrid ~> 1.2.0
+ typhoeus
+ pg

#Development#

##Config##
application.rb has separate sections for development and productions environments, see comments for details, it is pretty
straightforward.

##Contributing##
Fork, patch and submit a pull request. OR just email the code to jm@jmaddington.com

##Bugs, etc.##
Please open up a Github issue.

##Getting Help##
jm@jmaddington.com

Twitter: [@jmaddington](https://twitter.com/jmaddington)

##Credits##
[Two Rivers Church](http://www.tworiverschurch.org) sponsored the project, jmaddington managed it, [C.S. Preston](http://www.customsoftwarebypreston.com/) did all the initial coding.