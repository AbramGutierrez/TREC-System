class SessionsController < ApplicationController
  def new
  end
  
  def create

	# Check to see if admin
	account = Account.where('email = ? and user_type = ?', params[:session][:email].downcase, Administrator).take

	# If it is not an admin, then check to see if it belongs to a participant of the active conference
	if account.nil?
		accounts = Account.where('email = ?', params[:session][:email].downcase)
		accounts.each do |a|
			if a.user.is_a?(Participant)
				if a.user.team.conference.is_active?
					account = a
				end	
			end
		end
	end	

	# If it meets one of the two checks above, then authenticate with the password,
	# Otherwise do not allow login.
	if account && account.authenticate(params[:session][:password])
		log_in account
		if is_admin?
			redirect_back_or admin_dashboard_path
		elsif is_participant?
			redirect_back_or participant_dashboard_path
		else
			# This line should never be hit, but it is a safety check
			redirect_back_or root_url
		end
	else
		flash.now[:alert] = 'Invalid email/password combination'
		render 'new'
	end
  end
  
  def destroy
    log_out
	redirect_to root_url
  end
end
