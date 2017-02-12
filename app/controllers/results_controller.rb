class ResultsController < ApplicationController
	before_action :authenticate_user!
	helper_method :sort_column, :sort_direction

	def index
		@votes = Vote.group("entry_id")
		@entry=Entry.paginate(:page=>params[:page],:per_page=>10).recent
	end

	def winners
		#@contests = Contest.all
		if params[:search]
		    @contests = Contest.search(params[:search]).order("created_at DESC")
		    if @contests == ""
		    	flash[:notice] = "Contests not found, please check id"
		    else
		    	@entries = Entry.find_by_sql("SELECT e.*, if(e.entryvotes is NULL, count(v.id), e.entryvotes) as vote_count from entries e inner join votes v on e.id = v.entry_id where e.contest_id=#{params[:search]} group by e.id order by vote_count DESC limit 20")
		    	if !@entries
					flash[:notice] = "No Entries found"
				end
			end
		end
		#@entries = Entry.where('contest_id = ?',params[:search]).limit(20)
		
		#@entries = Entry.find_by_sql("SELECT e.*, if(e.entryvotes is NULL, count(v.id), e.entryvotes) as vote_count from entries e inner join votes v on e.id = v.entry_id where e.contest_id=#{params[:search]} order by vote_count DESC").limit(20)
		
		#@entries.sort { |e1,e2| e1.votes.length <=> e2.votes.length }
		
	end
end
