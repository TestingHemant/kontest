class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @contest = Contest.find(params[:contest_id])
    @entry = @contest.entries.create(entry_params)
    redirect_to contest_path(@contest)
    #@entry = Entry.new(entry_params)

    #respond_to do |format|
    #  if @entry.save
    #    format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
    #    format.json { render :show, status: :created, location: @entry }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @entry.errors, status: :unprocessable_entity }
    #  end
    #end
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
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
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
      params.require(:entry).permit(:contest_id, :uploaded_image,:image, :uploaded_video, :caption, :mobile, :email, :votes, :shares, :status, :rejected_reason)
    end
end
