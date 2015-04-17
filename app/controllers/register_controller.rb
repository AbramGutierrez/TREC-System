class RegisterController < ApplicationController
  def new
  end

  def create 
    account_params = {:email => register_params[:email], 
					  :password => register_params[:password], 
					  :password_confirmation => register_params[:password_confirmation], 
					  :first_name => register_params[:first_name], 
					  :last_name => register_params[:last_name]
					  }
					  
	participant_params = {:phone => register_params[:phone], 
						  :shirt_size => register_params[:shirt_size]
						 }
					  
	account = Account.new(account_params)
	participant = Participant.new(participant_params)
	
    respond_to do |format|
      if account.save
		  if participant.save
			log_in @account
	        ConfirmationMailer.welcome_email(@account).deliver_later
			format.html { redirect_to root_url, notice: 'Registration successful.' }
			# format.json { render :show, status: :created, location: participant }
		  else
			format.html { render :new }
			format.json { render json: participant.errors, status: :unprocessable_entity }
          end   
      else
        format.html { render :new }
        format.json { render json: account.errors, status: :unprocessable_entity }
      end
    end	
	
	
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def register_params
      params.require(:register).permit(:email, :password, :password_confirmation, 
		:first_name, :last_name, :phone, :shirt_size)
    end
end
