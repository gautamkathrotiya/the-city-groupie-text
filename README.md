Groupie Text
=====================

Plugin to allow group managers/leaders to send out group texts from The City, written in Ruby.

##Paid Hosting##
Paid hosting is available for this for this plugin, please contact jm@jmaddington.com or see [www.jmaddington.com](http://www.jmaddington.com)
for details. In many cases that will actually be **cheaper** than running it on your own.

##Usage##
###Configuration###
Copy config/configuration.sample.yml and rename or copy to config/configuration.yml. (configuration.yml is not distributed
so if you are pulling from git your settings won't be overwritten in the future.)

You will need to insert all of your own API keys, Twilio account info, etc. into configuration.yml. If you are only
running Groupie Text in production and not in development you can ignore the development section.

Next, open up config/database.yml and insert information for your own database. By default, this is set up for use
with Heroku.

Finally, config/initializers/secret_token.rb and put in a nice long random string in the last line.

You will need to create a new app in The City, as well as generating API keys for a User Admin to get the value for above.

Your new plugin should have the following permissions: group_content, user_basic

Contact The City help for support on this :-)

Next, open up app/assets/javascripts/groupie-text.js

    TheCity.PluginHelper.resizeIFrame({
      subdomain: '2rc',    //Change this to your City subdomain
      useSSL: true,       //Whether or not your plugin uses SSL
      extra: 450,           //Extra number of pixels to expand iFrame height to
      refresh: 0        //How often to check for new documentHeight, 0 to disable
    });

and replace the second line with **your** City subdomain.

###Database###
Before your first run you'll have to run ```rake db:migrate``` from the root of your Rails directory to initialize
the database. Currently, the database is only used for job queuing but Groupie Text will eventually support
cached copies of your City database.

###Job Worker###
You **need** to have a job worker running for any texts to actually be sent out! If you are self-hosting this probably
means running ```rake jobs:work``` from the root of your Rails app. If you are on Heroku you'll have to add a jobs
worker to your app.

##Requirements##

###Accounts###
Obviously you need a City account, including a User Admin. You will also need a [Twilio account](http://www.twilio.com)
as well as an SMTP account (for failed notifications).

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
+ delayed_job_active_record

Lograge is included by default but is not required.

###Jobs Worker###
Please see above under Configuration. If you don't have this, your texts will not be sent out.

##Contributing##
Fork, patch and submit a pull request. OR just email the code to jm@jmaddington.com

##Bugs, etc.##
Please open up a Github issue.

##Getting Help##
jm@jmaddington.com

[@jmaddington](https://twitter.com/jmaddington)

##Credits##
[Two Rivers Church](http://www.tworiverschurch.org) sponsored the project.