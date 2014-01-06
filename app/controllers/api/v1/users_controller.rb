class Api::V1::UsersController < Api::V1::BaseController
	def api_doc		
	end

	def index
		acc =  ApiKey.find_by_access_token(params[:auth_token])
		if acc
			#@user = User.find(ApiKey.find_by_access_token(params[:auth_token]).user_id) 
			@user = User.all
		else
			render_json({:errors => "auth_token missing or Invalid!", :status => 404}.to_json)
		end		
	end

	def show
		if params[:auth_token]
			@user = User.find(params[:id])
		else
			bad_record
		end	
	end
end
