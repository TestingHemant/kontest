class ResultsController < ApplicationController
	before_action :authenticate_user!
	helper_method :sort_column, :sort_direction

	def index
		@votes = Vote.group("entry_id")
		@entry=Entry.all
	end

	def winners
		@contests = Contest.all
		if params[:search]
		    @contests = Contest.search(params[:search]).order("created_at DESC")
		else
		    flash[:notice]="No such contest found"
		end
		@entries = Entry.where('contest_id = ?',params[:search])
		@entries.sort { |e1,e2| e1.votes.length <=> e2.votes.length }
	end
end
