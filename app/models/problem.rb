class Problem < ActiveRecord::Base
	scope :recent, -> {order("problems.created_at DESC")}
end
