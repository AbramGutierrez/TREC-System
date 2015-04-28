class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
    @account = Account.find_by(email: params[:password_reset][:email].downcase)
    if @account
      @account.randomize_email()
      PasswordMailer.reset_email(@account).deliver_now
      flash[:info] = "Email containing new password sent"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end
end
