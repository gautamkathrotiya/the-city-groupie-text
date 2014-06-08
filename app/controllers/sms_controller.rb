require 'twilio-ruby'
require 'send_messages'

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
	  Send_messages.send(params[:users_id] ,params[:group], params[:leader], params[:message])
		
		render json: @users_id.to_json
	end

end
