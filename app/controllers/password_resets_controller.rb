class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
    accounts = Account.get_active
    index = accounts.index{|account| account.email == params[:password_reset][:email].downcase}
    if index
      @account = accounts[index]
      @account.randomize_password()
      begin
        PasswordMailer.reset_email(@account).deliver_now!
      rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
        flash.now[:alert] = "Error sending email."
        render 'new' and return
      end
      flash[:info] = "Email containing new password sent"
      redirect_to root_url and return
    else
      flash.now[:danger] = "Email address not found"
      render 'new' and return
    end
  end
end
