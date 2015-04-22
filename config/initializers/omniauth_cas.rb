Rails.application.config.middleware.use OmniAuth::Builder do

provider :cas,
         host:      'cas-dev.tamu.edu',
         login_url: '/cas/login',
         service_validate_url: '/cas/serviceValidate',
		 logout_url: 'cas/logout'

end
