class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # Before Filter
	# Ensure that a user is logged in to an account
	def logged_in_user
	  unless logged_in?
	    store_location
	    flash[:alert] = "Please log in."
		redirect_to login_url
	  end	
	end
	
	# Ensure that the user is an admin
	def admin_account
	  redirect_to(root_url) unless current_account.user.is_a?(Administrator)	
	end
	
	# Ensure that the user is a participant
	def participant_account
	  redirect_to(root_url) unless current_account.user.is_a?(Participant)	
	end
end
