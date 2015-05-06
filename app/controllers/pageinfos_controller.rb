class PageinfosController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_pageinfo, only: [:show, :edit, :update, :destroy]
  before_action :admin_account, only: [:index, :new, :edit, :create, :update, :destroy]

  # GET /pageinfos
  # GET /pageinfos.json
  def index
    @pageinfos = Pageinfo.all
  end

  # GET /pageinfos/1
  # GET /pageinfos/1.json
  def show
  end

  # GET /pageinfos/new
  def new
    @pageinfo = Pageinfo.new
  end

  # GET /pageinfos/1/edit
  def edit
  end

  # POST /pageinfos
  # POST /pageinfos.json
  def create
    @pageinfo = Pageinfo.new(pageinfo_params)

    respond_to do |format|
      if @pageinfo.save
        format.html { redirect_to @pageinfo, notice: 'Pageinfo was successfully created.' }
        format.json { render :show, status: :created, location: @pageinfo }
      else
        format.html { render :new }
        format.json { render json: @pageinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pageinfos/1
  # PATCH/PUT /pageinfos/1.json
  def update
    respond_to do |format|
      if @pageinfo.update(pageinfo_params)
        format.html { redirect_to @pageinfo, notice: 'Pageinfo was successfully updated.' }
        format.json { render :show, status: :ok, location: @pageinfo }
      else
        format.html { render :edit }
        format.json { render json: @pageinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pageinfos/1
  # DELETE /pageinfos/1.json
  def destroy
    @pageinfo.destroy
    respond_to do |format|
      format.html { redirect_to pageinfos_url, notice: 'Pageinfo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pageinfo
      @pageinfo = Pageinfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pageinfo_params
      params.require(:pageinfo).permit(:page, :body)
    end
end
