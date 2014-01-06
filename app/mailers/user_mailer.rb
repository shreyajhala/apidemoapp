class UserMailer < ActionMailer::Base
  default from: "apidemo@example.com"
  
  def password_mail(user)
  	@user = user 
  	mail(to: @user.email, subject: "Forgot Password Request")
  end


end
