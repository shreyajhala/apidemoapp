config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
	address: 'smtp.gmail.com',
	port: 587,
	domail: 'localhost:3000',
	user_name: 'cspltesting@gmail.com',
	password: 'complitech',
	authentication: 'plain',
	enable_starttls_auto: true
}