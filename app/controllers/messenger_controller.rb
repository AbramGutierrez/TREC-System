class MessengerController < ApplicationController
  
  before_action :logged_in_user, only: [:new, :create]
  before_action :admin_account, only: [:new, :create]
  
  def new
  end
  
  def create
    if !flash[:alert].nil?
      if !flash[:alert].empty?
        flash[:alert].clear
      end
    end
    
    @recipients = params[:recipients]
    @method = params[:method]
    if (@recipients == nil || @method == nil)
      if (@recipients == nil)
        flash[:alert] = "Please select a recipient."
      end
      if (@method == nil)
        if !flash[:alert].nil? && !flash[:alert].empty?
          flash[:alert] << "\nPlease select a message type."
        else
          flash[:alert] = "Please select a message type."
        end
      end
    end
    
    @subject = params[:title_box]["message_title"]
    @message = params[:message_box]["message_body"]
    
    if @method == Administrator.method_text_message && @message.length > 160 
      if !flash[:alert].nil? && !flash[:alert].empty?
        flash[:alert] << "\nYour message was " + @message.length.to_s + 
        " characters long, but text messages can only be 160 characters."
      else
        flash[:alert] = "Your message was " + @message.length.to_s + 
        " characters long, but text messages can only be 160 characters."
      end
      
    end
    
    if @message.empty?
      if !flash[:alert].nil? && !flash[:alert].empty?
        flash[:alert] << "\nPlease input a message."
      else
        flash[:alert] = "Please input a message."
      end
    end
    
    if @subject.empty?
      if !flash[:alert].nil? && !flash[:alert].empty?
        flash[:alert] << "\nPlease input a subject."
      else
        flash[:alert] = "Please input a subject."
      end
    end
    
    if !flash[:alert].nil? && !flash[:alert].empty?
      render "new" and return
      return
    end
    
    begin
      Administrator.email(@recipients, @method, @subject, @message)
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash.now[:alert] = "Error sending email. Please check your connection."
      render 'new' and return
    end
    
    render "success" and return
  end
end
