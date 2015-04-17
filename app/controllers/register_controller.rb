class RegisterController < ApplicationController
  def new
  end

  def create				  
	participant_params = {:phone => params[:register][:phone], 
						  :shirt_size => params[:register][:shirt_size]
						 }
	participant = Participant.new(participant_params)
	
    respond_to do |format|
	  if participant.save
	      account_params = {:email => params[:register][:email], 
							:password => params[:register][:password], 
							:password_confirmation => params[:register][:password_confirmation], 
							:first_name => params[:register][:first_name], 
							:last_name => params[:register][:last_name],
							:user => participant
							}
	      puts "\naccount_params: #{account_params.inspect}\n"				  
	      account = Account.new(account_params)
		  if account.save
			log_in account
			ConfirmationMailer.welcome_email(account).deliver_later
			format.html { redirect_to root_url, notice: 'Registration successful.' }
			# format.json { render :show, status: :created, location: participant }
		  else
			puts "\naccount save failed\n"
			format.html { render :new }
			format.json { render json: account.errors, status: :unprocessable_entity }
		  end
	  else
		puts "\nparticipant save failed\n"
		format.html { render :new }
		format.json { render json: participant.errors, status: :unprocessable_entity }
	  end  
    end	
	
	
  end
  
end
