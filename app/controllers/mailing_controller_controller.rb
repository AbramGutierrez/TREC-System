class MailingControllerController < ApplicationController
  #These confuse me. I feel like I only need admin_account portion
  before_action :logged_in_user, only: [:new]
  before_action :set_account, only: [:new]
  before_action :correct_user, only: [:new]
  before_action :admin_account, only: [:new]
  
  def new
    
  end
end
