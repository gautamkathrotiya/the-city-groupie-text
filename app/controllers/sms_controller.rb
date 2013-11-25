require 'twilio-ruby'

class SmsController < ApplicationController

	def index		
		@body = params['message']
		@to = params['to']
		@client = Twilio::REST::Client.new(Rcplugin::TWILIO_ACCOUNT, Rcplugin::TWILIO_TOKENID)
		@account = @client.account
		@message = @account.sms.messages.create({:from => Rcplugin::TWILIO_FROM_NUMBER, :to => @to, :body => @body})
		puts @message		
	end

	def sendsms
		@users_id = params[:users_id].split(/,\s*/)
		@client = Twilio::REST::Client.new(Rcplugin::TWILIO_ACCOUNT, Rcplugin::TWILIO_TOKENID)
		@group = params['group']
		@leader = params['leader']
		@subject = "From: #{@leader} To: #{@group}"
		@account = @client.account
		@body = params['message']
		
		puts "Hello, logs!"

		@users_id.each do |user_id|
				TheCityAdmin::AdminApi.connect(Rcplugin::CITY_ADMIN_SECRET,Rcplugin::CITY_USER_TOKEN)
				@user = TheCityAdmin::User.load_by_id(user_id)
				
				if(@user.primary_phone != '' && @user.primary_phone_type != 'Home')
					puts "Calling SMS"
					puts "#{@user.primary_phone}"
					@message = @account.sms.messages.create({:from => Rcplugin::TWILIO_FROM_NUMBER, :to => "#{@user.primary_phone}", :body => "From: #{@leader} To: #{@group} : #{@body}" })
					puts "#{@message.inspect}"
				else
				   puts "Calling Email"
				   puts "#{@user.email}"
				   Notifier.send_group_email(@user,@body,@subject).deliver
				end	
		end	
		
		render json: @users_id.to_json
	end

end
