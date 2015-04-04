module SessionsHelper

	# Logs in the given account.
	def log_in(account)
		session[:account_id] = account.id
	end
	
	# Returns the current logged-in account (if there is one).
	def current_account
		@currect_account ||= Account.find_by(id: session[:account_id])
	end
	
	# Returns true if the account is logged in, false otherwise.
	def logged_in?
		!current_account.nil?
	end
	
	#Logs out the current user.
	def log_out
		session.delete(:account_id)
		@current_account = nil
	end
end
