require 'twilio-ruby'
require 'cityadmin/the_city_admin'

module Send_messages
  def self.send(users_ids, group, leader, message)
    users_id = users_ids.split(/,\s*/)

    users_id.each do |user_id|
      puts "CTDEBUG: Queuing user id #{user_id} for lookup"
      self.lookup_user(user_id, group, leader, message)
    end
  end

  def self.lookup_user(user_id, group, leader, message)
    @group = group
    @leader = leader
    @message = message

    TheCityAdmin::AdminApi.connect(Rcplugin::CITY_ADMIN_SECRET,Rcplugin::CITY_USER_TOKEN)
    @user = TheCityAdmin::User.load_by_id(user_id)

    puts "CTDEBUG: Sending SMS to #{@user.full_name}"
    if(@user.primary_phone != '' && @user.primary_phone_type != 'Home')
      client = Twilio::REST::Client.new(Rcplugin::TWILIO_ACCOUNT, Rcplugin::TWILIO_TOKENID)
      account = client.account

      puts "CTDEBUG: Queuing SMS to #{@user.primary_phone}"
      twilio_message = account.sms.messages.delay.create({:from => Rcplugin::TWILIO_FROM_NUMBER, :to => "#{@user.primary_phone}", :body => "From: #{@leader} To: #{@group} : #{@message}" })
    elsif not @user.email.nil?
      puts "CTDEBUG: Sending email to #{@user.full_name} <#{@user.email}>"
      Notifier.send_group_email(@user, message, "From: #{@leader} To: #{@group}").deliver
    else
      puts "CTDEBUG: #{@user.full_name} didn't have an email address or a mobile :-("
    end

  end
end