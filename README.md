the-city-groupie-text
=====================

Plugin to allow group managers/leaders to send out texts from The City, written in Ruby.

##Usage##

Open up application.rb and replace all the following lines with your own information from The City:

    #Replace everything below with your own info
    THE_CITY_SECRET = 'YOUR CITY APP SECRET'
    THE_CITY_APP_ID = 'YOUR CITY APP ID'

    TWILIO_ACCOUNT = 'YOUR TWILIO ACCOUNT'
    TWILIO_TOKENID = 'YOUR TWILIO TOKEN'
    TWILIO_FROM_NUMBER = 'YOUR TWILIO NUMBER' #like '+15551231234'

    CITY_ADMIN_SECRET = 'YOUR CITY ADMIN SECRET'
    CITY_USER_TOKEN = 'YOUR CITY USER TOKEN'

    CITY_SUBDOMAIN = 'YOUR CITY SUBDOMAIN'

    SMTP_USER = 'YOUR SMTP SERVER USERNAME'
    SMTP_PASSWORD = 'YOUR SMTP SERVER PASSWORD'
    SMTP_DOMAIN = 'YOUR EMAIL DOMAIN'
    SMTP_ADDRESS = 'YOUR SMTP SERVER ADDRESS'
    SMTP_FROM = 'YOUR SMTP SERVER ADDRESS'
    SMTP_PORT =' YOUR SMTP SERVER PORT'
    SMTP_TLS = true #Change as needed
    
You will need to create a new app in The City, as well as generating API keys for a User Admin to get the value for above. Contact The City help for support on this :-)

Next, open up app/assets/javascripts/groupie-text.js

    TheCity.PluginHelper.resizeIFrame({
      subdomain: '2rc',    //Change this to your City subdomain
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

##Contributing##
Fork, patch and submit a pull request. OR just email the code to jm@jmaddington.com

##Bugs, etc.##
Please open up a Github issue.

##Getting Help##
jm@jmaddington.com

[@jmaddington](https://twitter.com/jmaddington)

##Credits##
[Two Rivers Church](http://www.tworiverschurch.org) sponsored the project, jmaddington managed it, [C.S. Preston](http://www.customsoftwarebypreston.com/) did all the initial coding.