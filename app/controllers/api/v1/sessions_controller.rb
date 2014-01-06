class Api::V1::SessionsController < Api::V1::BaseController
	skip_before_filter :verify_authenticity_token, :only => [:forgot_password]

	def forgot_password
		if params[:user][:email]
			@user = User.find_by_email(params[:user][:email])
			if @user
				UserMailer.password_mail(@user).deliver if @user
				render_json({:message => "Email sent!", :status => 200}.to_json)
			else
				render_json({:errors => "Email not found try again!", :status => 404}.to_json)
			end
		else
			render_json({:errors => "Invalid email or email missing", :status => 404}.to_json)
		end
	end

	def create
		if params[:user][:email] && params[:user][:password]
			@user = User.find_by_email(params[:user][:email])
			if @user && @user.authenticate(params[:user][:password])
				auth_token = @user.api_key.create
				render 'api/v1/users/show'
			else
				render_json({:errors => "Invalid email/password!", :status => 404}.to_json)
			end
		else
			render_json({:errors => "blank", :status => 404}.to_json)
		end
	end

	def destroy
		if params[:id]
			@user = User.find(params[:id])
			if @user
				ApiKey.find_by_user_id(@user.id).destroy
				render_json({:message => "Sucessful Logout!", :status => 200}.to_json)
			else
				bad_record
			end
		else
			render_json({:errors => "ID missing!", :status => 404}.to_json)
		end
	end 

end
