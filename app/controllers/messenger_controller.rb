class MessengerController < ApplicationController
  #These confuse me. I feel like I only need admin_account portion
  before_action :logged_in_user, only: [:new]
  before_action :admin_account, only: [:new]
  
  def new
  end
  
  def create
    @recipients = params[:recipients]
    @method = params[:method]
    if (@recipients == nil || @method == nil)
      if (@recipients == nil)
        flash.now[:alert] = "Please select a recipient"
      end
      if (@method == nil)
        flash.now[:alert] = "Please select a method"
      end
      render "new" and return
    end
    
    @title = params[:title_box]["message_title"]
    @message = params[:message_box]["message_body"]
    
    begin
      Administrator.email(@recipients, @method, @title, @message).deliver_now!
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash.now[:alert] = "Error sending email. Please check your connection."
      render 'new' and return
    end
    
    render "success" and return
  end
end
