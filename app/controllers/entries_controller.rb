class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: :show
  layout "entry", only: [:show]
  # GET /entries
  # GET /entries.json
  def index
    @entry = Entry.all
    @entries = Entry.paginate(:page=>params[:page],:per_page=>10).recent
    #@entries = Entry.all
  end

  def conentries
    if params[:search]
        @contests = Contest.search(params[:search]).order("created_at DESC")
        if @contests == ""
          flash[:notice] = "Contests not found, please check id"
        end
    end
    #@entries = Entry.where('contest_id = ?',params[:search]).limit(20)
    @conentries = Entry.where('contest_id = ?', params[:search]).paginate(:page=>params[:page],:per_page=>10).recent
  end

  def entrylist
    if current_user && current_user.admin?
      @entries = Entry.paginate(:page=>params[:page],:per_page=>10).recent
    else
      flash[:notice] = "No such page exists"
      redirect_to root_path
    end
  end

  def mycontest
    @user = User.find(current_user.id)
    @userentries = Entry.where(user_id: @user)
    if @userentries.blank?
      render "entries/nocontests"
    end
  end
  # GET /entries/1
  # GET /entries/1.json
  def show
    @relentry = Entry.by_status('Approved').where(contest_id: @entry.contest_id)
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
    if current_user && current_user.admin?
    else
      flash[:notice] = "No such page exists"
      redirect_to root_path
    end
  end

  # POST /entries
  # POST /entries.json
  def create
    @contest = Contest.find(params[:contest_id])
    params[:entry][:status]="Submitted"
    params[:entry][:user_id]=current_user.id
    @entry = @contest.entries.create(entry_params)
    if @entry.save
      redirect_to entry_path(@entry)
      flash[:success] = "Entry submitted successfully"
      require 'msg91ruby'
      api = Msg91ruby::API.new("155559AcDj9QWtpxN5939806a","KRAZYK")
      api.send(params[:entry][:mobile], "Thank you, #{current_user.name}, for participating in our contest. Here is your link \"http://www.krazykontest.com#{entry_path(@entry)}\". Start collecting votes to win prizes. Follow us fb.com/krazykontests", 4)
    else
      flash[:error] = "All fields are mandatory"
      redirect_to :back
    end
  end

  #voting 
  def upvote
    @entry = Entry.find(params[:id])
    @success=@entry.votes.create(user_id: current_user.id)
    if @success.save
      flash[:notice] =  "Thank you for upvoting!"
      redirect_to :back
    else 
      flash[:notice] =  "You have already upvoted this!"
      redirect_to :back
    end
    #@entry.votes.create
    #redirect_to(entries_path)
    #redirect_to :back
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update    
    respond_to do |format|
      if params[:entry][:status] == 'Rejected'
        if @entry.update(entry_params)
          require 'msg91ruby'
          api = Msg91ruby::API.new("155559AcDj9QWtpxN5939806a","KRAZYK")
          api.send(@entry.mobile, "Dear participant, We are sorry to inform you that your entry is invalid. Read our description and steps properly and do participate again. Regards Krazykontest", 4)
          format.html { redirect_to "/entries", notice: 'Entry was successfully updated - Reject SMS.' }
          format.json { render :show, status: :ok, location: @entry }
        end
          format.html { redirect_to "/entries", notice: 'Entry was successfully updated.' }
          format.json { render :show, status: :ok, location: @entry }
      else
        params[:entry][:rejected_reason] = ""
        if @entry.update(entry_params)
          format.html { redirect_to "/entries", notice: 'Entry was successfully updated - No SMS.' }
          format.json { render :show, status: :ok, location: @entry }
        else
          format.html { render :edit }
          format.json { render json: @entry.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def overide
    @user=User.find(current_user.id)
    @entry=Entry.find(params[:id])
    params[:entry][:entryvotes] = params[:entryvotes]
    respond_to do |format|
      if @entry.update_attributes(:entryvotes)
        flash[:notice] =  "Vote counts updated successfully."
        redirect_to "/results"
        #format.html { redirect_to "/results", notice: 'Vote counts updated successfully.' }
        #format.json { render :show, status: :ok, location: @entry }
      else
        flash[:notice] =  "Not Editable"
        #format.html { render :edit }
        #format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:contest_id, :uploaded_image,:image, :uploaded_video, :caption, :mobile, :email, :shares, :status, :rejected_reason,:user_id,:entryvotes)
    end
end
