class ContestsController < ApplicationController
  before_action :set_contest, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except=>[:index]
  # GET /contests
  # GET /contests.json
  def index
    #@user=User.find(params[:user_id])
    @homeentries = Entry.by_status('Approved').recent.limit(16)
    @contests = Contest.by_status('Active').where("end_date >= ?", Time.zone.now)
    @megacontests = Contest.by_status('Active').where("end_date >= ?", Time.zone.now).where("contest_type = ?","Mega")
    @monthlycontests = Contest.by_status('Active').where("end_date >= ?", Time.zone.now).where("contest_type = ?","Monthly")
    @weeklycontests = Contest.by_status('Active').where("end_date >= ?", Time.zone.now).where("contest_type = ?","Weekly")
    @dailycontests = Contest.by_status('Active').where("end_date >= ?", Time.zone.now).where("contest_type = ?","Daily")
    
    if @contests.blank?
      render "shared/nocontest"
    end
  end

  def completedcontest
    @completed = Contest.by_status('Completed')
    @upcoming = Contest.by_status('UpComing')
    @suspended = Contest.by_status('Suspended')
  end

  def contestlist
    #@program = Program.paginate(:page=>params[:page],:per_page=>10).by_status('active').recent  
    if current_user && current_user.admin?
      @contests = Contest.paginate(:page=>params[:page],:per_page=>10).recent
    else
      flash[:notice] = "No Such page found"
      redirect_to root_path
    end
  end
  # GET /contests/1
  # GET /contests/1.json
  def show
  end

  # GET /contests/new
  def new
    if current_user && current_user.admin?
      @contest = Contest.new
    else
      flash[:notice] = "No Such page found"
      redirect_to root_path
    end
  end

  # GET /contests/1/edit
  def edit
    if current_user && current_user.admin?
    else
      flash[:notice] = "No Such page found"
      redirect_to root_path
    end
  end

  # POST /contests
  # POST /contests.json
  def create
    #params[:user_id]=current_user.id
    if params[:contest_type] == "Select Contest Type"
      flash[:error] = "Please select Contest Type"
    else
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
