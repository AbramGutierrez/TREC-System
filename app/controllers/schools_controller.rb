class SchoolsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]	
  before_action :admin_account, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_school, only: [:show, :edit, :update, :destroy]  

  def index
    @schools = School.all
  end

  def show
  end

  def new
    @school = School.new
  end

  def edit
  end

  def create
    @school = School.new(school_params)
	if @school.save
	  flash[:notice] = 'School was successfully created.'
	  redirect_to schools_url
	else
      render :new	
	end
  end

  def update
    if @school.update(school_params)
	  flash[:notice] = 'School was successfully updated.'
	  redirect_to schools_url
	else
	  render :edit
	end
  end

  def destroy
    @school.destroy
	flash[:notice] = 'School was successfully destroyed.'
	redirect_to schools_url
  end
  
  private
    def set_school
      @school = School.find(params[:id])
    end
	
	def school_params
      params.require(:school).permit(:name)
    end
end
