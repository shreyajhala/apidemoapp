class Api::V1::RegistrationController < Api::V1::BaseController
	#before_filter :restrict_access
  
  	def create
		@user = User.new(user_params)
		
		if @user.save
			@user.api_key.create
			render "api/v1/users/show"
		else
			render_json({:errors => @user.errors.full_messages, :status => 404}.to_json)
		end
	end

	def destroy
		
		user = User.find(params[:id])
		if user
			user.destroy
			render_json({:message => "user sucessfully deleted", :status => 200}.to_json)
		else
			bad_record
		end
	end

	private
	def user_params
    	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


    def restrict_access
    	authenticate_or_request_with_http_token do |token, options|
    		ApiKey.exists?(access_token: token)
    	end
    end
end