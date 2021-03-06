class SponsorshipsController < ApplicationController
  before_action :set_sponsorship, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_user!, :except=>[:new, :create]

  # GET /sponsorships
  # GET /sponsorships.json
  def index
    if current_user && current_user.admin?
      @sponsorships = Sponsorship.paginate(:page=>params[:page],:per_page=>10).recent
    else
      #flash[:notice] = "No such page exists"
      redirect_to new_sponsorship_path
    end    
  end

  # GET /sponsorships/1
  # GET /sponsorships/1.json
  def show
    if current_user && current_user.admin?
    else
      #flash[:notice] = "No such page exists"
      redirect_to new_sponsorship_path
    end  
  end

  # GET /sponsorships/new
  def new
    @sponsorship = Sponsorship.new
  end

  # GET /sponsorships/1/edit
  def edit
    if current_user && current_user.admin?
    else
      flash[:notice] = "No such page exists"
      redirect_to root_path
    end  
  end

  # POST /sponsorships
  # POST /sponsorships.json
  def create
    @sponsorship = Sponsorship.new(sponsorship_params)

    respond_to do |format|
      if @sponsorship.save
        format.html { redirect_to "/sponsorships/new", notice: 'Thanks for contacting. We will get back to you as soon as possible.' }
        format.json { render :new, status: :created, location: @sponsorship }
      else
        format.html { render :new }
        format.json { render json: @sponsorship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sponsorships/1
  # PATCH/PUT /sponsorships/1.json
  def update
    respond_to do |format|
      if @sponsorship.update(sponsorship_params)
        format.html { redirect_to @sponsorship, notice: 'Sponsorship was successfully updated.' }
        format.json { render :show, status: :ok, location: @sponsorship }
      else
        format.html { render :edit }
        format.json { render json: @sponsorship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sponsorships/1
  # DELETE /sponsorships/1.json
  #def destroy
  #  @sponsorship.destroy
  #  respond_to do |format|
  #    format.html { redirect_to sponsorships_url, notice: 'Sponsorship was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sponsorship
      @sponsorship = Sponsorship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sponsorship_params
      params.require(:sponsorship).permit(:name, :email, :phone, :message)
    end
end
