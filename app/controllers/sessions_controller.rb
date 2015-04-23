class SessionsController < ApplicationController
  def new
  end
  
  def create
	email = params[:session][:email].downcase
	account = Account.find_by(email: params[:session][:email].downcase)
	if account && account.authenticate(params[:session][:password])
		log_in account
		if is_admin?
			redirect_to admin_dashboard_path
		elsif is_participant?
			redirect_to participant_dashboard_path
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
