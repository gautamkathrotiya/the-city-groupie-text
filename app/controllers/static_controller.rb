require 'the_city'
require 'rc_auth'
require 'cityadmin/the_city_admin'
require 'json'

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
			@groups = Array.new

      #@me.groups is not array, so we'll put it into one so we can sort later
      @me.groups.each do |group|
        @groups << group
      end
			count = 0

      if Rcplugin::DEV_ENV == true
        puts "CTDEBUG: Groups raw output #{@groups.inspect}"
      end

			@groups.each do |group|
        #Sort groups
        if Rcplugin::DEV_ENV == true
          puts 'CTDEBUG: User is ' + group.role_title + ' of ' + group.name
        end

        @groups.sort! {|a,b| a.name.downcase <=> b.name.downcase }

        if group.role_title == 'Leader' || group.role_title == 'Manager'
					count += 1
				end	
			end
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

#This is method to get members of group
#URL: /groupmember
#Method:POST
# * ARGS *
#id => group id
#page_id => Page Number
#return memberslist in JSON format

	def get_group_members
		id = params[:id]

    #Get the initial call of members in the group
    members_initial  = TheCityAdmin::GroupRoleList.new({:group_id => id})
    @total_count = members_initial.total_pages
    @members = Array.new

    members_initial.each do |member|
      @members << member
    end

    if Rcplugin::DEV_ENV == true
        puts "CTDEBUG: Total pages to get #{members_initial.total_pages}"
        puts 'CTDEBUG: Group list for id: ' + id
        puts members_initial.to_json
    end

    #If there is more than one page loop through all the pages and then return
    if @total_count > 1
      for i in 2..@total_count
        TheCityAdmin::AdminApi.connect(Rcplugin::CITY_ADMIN_SECRET,Rcplugin::CITY_USER_TOKEN)
        members = TheCityAdmin::GroupRoleList.new({:group_id => id,:page => i})
        members.each do |member|
          @members << member
        end
      end
    end

    if Rcplugin::DEV_ENV == true
      puts 'CTDEBUG: Final members list in JSON'
      puts @members.to_json
    end

		render json: @members.to_json
	end

#This is method to get number of pages in group
#URL: /groupcount
#Method:POST
# * ARGS *
#id => group id
#return count in JSON format	

	def get_group_count
		id = params[:id]
		TheCityAdmin::AdminApi.connect(Rcplugin::CITY_ADMIN_SECRET,Rcplugin::CITY_USER_TOKEN)
		@members = TheCityAdmin::GroupRoleList.new({:group_id => id})
		@count = Hash.new
		@count['count'] = @members.total_pages
		render json: @count.to_json
		
	end

#Test purpose
#Method: GET
#Geting member list based on group id 
#Output: memberslist in HASH format

	def group_service
		id = params[:id]
		TheCityAdmin::AdminApi.connect(Rcplugin::CITY_ADMIN_SECRET,Rcplugin::CITY_USER_TOKEN)
		@members = TheCityAdmin::GroupRoleList.new({:group_id => id})

		@total_count = @members.total_pages
		@membersList = Array.new
		@membersListv1 = Array.new
		for i in 2..@total_count
			@members_v1 = TheCityAdmin::GroupRoleList.new({:group_id => id,:page => i})
			@mem_json = @members_v1.to_json
			@membersList[i] = @mem_json
		end	


	end

#Test purpose
#Method: GET
#Geting Group list based on user
#Output: Grouplist in HASH format

	def user_service
		TheCityAdmin::AdminApi.connect(Rcplugin::CITY_ADMIN_SECRET,Rcplugin::CITY_USER_TOKEN)

		@group = TheCityAdmin::GroupList.new
	end

#Test purpose
#Method: GET
#Geting user details based on user id
#Output: Userdetails in HASH format
	def get_user_details
		id = params[:id]
		TheCityAdmin::AdminApi.connect(Rcplugin::CITY_ADMIN_SECRET,Rcplugin::CITY_USER_TOKEN)
		@user = TheCityAdmin::User.load_by_id(id)
	end

end