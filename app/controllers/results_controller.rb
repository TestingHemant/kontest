class ResultsController < ApplicationController
	before_action :authenticate_user!
	helper_method :sort_column, :sort_direction
	def index
		#@contests = Contest.all#where("status = ?", "Completed")
		#@entries = Entry.where("contest_id", @contests)
		#@totalvotes = Vote.all
		#@contests = Contest.order(sort_column + " " + sort_direction)
		@votes = Vote.group("entry_id")
		#@user=User.find_by_id(@entries)
		@entry=Entry.all
	end
end
