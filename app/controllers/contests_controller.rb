class ContestsController < ApplicationController
  before_action :set_contest, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except=>[:index]
  # GET /contests
  # GET /contests.json
  def index
    #@user=User.find(params[:user_id])
    @homeentries = Entry.recent
    @contests = Contest.all
    @contests = Contest.where("end_date >= ?", Time.zone.now.beginning_of_day)
    if @contests.blank?
      render "shared/nocontest"
    end
  end
  def contestlist
    #@program = Program.paginate(:page=>params[:page],:per_page=>10).by_status('active').recent  
    @contests = Contest.paginate(:page=>params[:page],:per_page=>10).recent
  end
  # GET /contests/1
  # GET /contests/1.json
  def show
  end

  # GET /contests/new
  def new
    @contest = Contest.new
  end

  # GET /contests/1/edit
  def edit
  end

  # POST /contests
  # POST /contests.json
  def create
    #params[:user_id]=current_user.id
    params[:contest][:user_id]=current_user.id
    @contest = Contest.new(contest_params)    
    respond_to do |format|
      if @contest.save
        format.html { redirect_to @contest, notice: 'Contest was successfully created.' }
        format.json { render :show, status: :created, location: @contest }
      else
        format.html { render :new }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contests/1
  # PATCH/PUT /contests/1.json
  def update
    respond_to do |format|
      if @contest.update(contest_params)
        format.html { redirect_to @contest, notice: 'Contest was successfully updated.' }
        format.json { render :show, status: :ok, location: @contest }
      else
        format.html { render :edit }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contests/1
  # DELETE /contests/1.json
  def destroy
    @contest=Contest.find(params[:id])
    #@contest.destroy
    begin
      respond_to do |format|
        if @contest.update_attributes(:status=>"deleted")
          format.html { redirect_to :back, notice: 'Contest removed successfully.' }
          format.json { head :no_content }
        else
          flash[:notice] = "Can not be removed"
          redirect_to :back
          #format.json {render json: @contest.errors, status: :unprocessable_entity}
          #redirect_to recruiter_root_path, :flash => {:error => "Something Went Wrong"}  
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      redirect_to :back
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contest
      @contest = Contest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contest_params
      params.require(:contest).permit(:title, :contest_type, :banner, :image, :description, :steps, :first_prize, :second_prize, :third_prize, :status, :suspension_reason, :start_date, :end_date,:user_id)
    end
end
