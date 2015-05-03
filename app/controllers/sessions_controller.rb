class SessionsController < ApplicationController
  def new
  end
  
  def create
	# email = params[:session][:email].downcase
	# puts "\nEmail: #{email}\n"
	# Check to see if admin
	account = Account.where('email = ? and user_type = ?', params[:session][:email].downcase, Administrator).take
	# puts "\naccount0: #{account.inspect}\n"
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
	# puts "\naccount: #{account.inspect}\n"
	# if account.nil?
		# puts "\nNIL!!!\n"
	# end
	# account = Account.find_by(email: params[:session][:email].downcase)
	if account && account.authenticate(params[:session][:password])
		log_in account
		if is_admin?
			redirect_back_or admin_dashboard_path
		elsif is_participant?
			redirect_back_or participant_dashboard_path
		else
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
