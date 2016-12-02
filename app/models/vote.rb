class Vote < ActiveRecord::Base
	belongs_to :entry
	belongs_to :user
	validates_uniqueness_of :entry_id, scope: :user_id
end
