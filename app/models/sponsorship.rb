class Sponsorship < ActiveRecord::Base
	scope :recent, -> {order("sponsorships.created_at DESC")}
	validates :email, :presence => {:message => " can't be blank." }
	validates :name, :presence => {:message => " can't be blank." }
end
