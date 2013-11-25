require 'the_city'
require 'rc_auth'
require 'cityadmin/the_city_admin'

class StaticController < ApplicationController

  skip_before_filter :verify_authenticity_token

	def index
		json = RcAuth::decrypt_city_data(params['city_data'],params['city_data_iv'],Rcplugin::THE_CITY_SECRET[0,32])


		if not json.empty?
			@data = JSON.restore(json)
			@subdomain = @data['subdomain']
			@token = @data['oauth_token']

			@client = TheCity::API::Client.new do |config|
				config.app_id = Rcplugin::THE_CITY_APP_ID
				config.app_secret = Rcplugin::THE_CITY_SECRET
				config.access_token = @token
				config.subdomain = @subdomain
			end
			session[:user] = @me
			@me = @client.me
			@name = @me.name
			@userid = @me.id
			@groups = @me.groups
			count = 0
			@groups.each do |group|
				if group.role_title == 'Leader'
					count += 1
				end	
			end	
			puts @groups.inspect
			@count = count
			puts @count
			@members = {}
		else
			@name = "Guest"
		end
		if params['group']
			@groups = {}
			TheCityAdmin::AdminApi.connect(Rcplugin::CITY_ADMIN_SECRET,Rcplugin::CITY_USER_TOKEN)
			@members = TheCityAdmin::GroupRoleList.new({:group_id => params['group']})
		end
	end

	def get_group_members
		id = params[:id]
		TheCityAdmin::AdminApi.connect(Rcplugin::CITY_ADMIN_SECRET,Rcplugin::CITY_USER_TOKEN)
		@members = TheCityAdmin::GroupRoleList.new({:group_id => id})
		render json: @members.to_json
		
	end

	def group_service
		TheCityAdmin::AdminApi.connect(Rcplugin::CITY_ADMIN_SECRET,Rcplugin::CITY_USER_TOKEN)
		@members = TheCityAdmin::GroupRoleList.new({:group_id => 109302})

	end


	def user_service
		TheCityAdmin::AdminApi.connect(Rcplugin::CITY_ADMIN_SECRET,Rcplugin::CITY_USER_TOKEN)
		@group = TheCityAdmin::GroupList.new
		
	end

	def get_user_details
		id = params[:id]
		TheCityAdmin::AdminApi.connect(Rcplugin::CITY_ADMIN_SECRET,Rcplugin::CITY_USER_TOKEN)
		@user = TheCityAdmin::User.load_by_id(id)
	end

end