class User < ActiveRecord::Base
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_RGEXP = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_RGEXP }, uniqueness:  true
	validates :password, length: { minimum: 5 }
	has_secure_password

	has_many :api_key, :dependent => :destroy
end
