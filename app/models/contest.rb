class Contest < ActiveRecord::Base
	has_many :entries, :dependent => :destroy
	belongs_to :users
	validates :title,:description,:steps, :presence => true
	validates :first_prize, :presence => true
	validates_uniqueness_of :contest_type, scope: :status #if: :same_status?
	validate :validate_contest_type

	scope :by_status, -> status { where(status: status) }
	scope :recent, -> {order("contests.created_at DESC")}
    
    def validate_contest_type
    	if :contest_type == "Select Contest Type"
    		errors.add_to_base("Please select contest type")
    	end
    end

    def self.search(search)
    	#where("title LIKE ?", "%#{search}%")
    	where("id = ?", "#{search}")
    end

    def same_status?
     status == "active" || status="Active"
    end

	has_attached_file :image, styles: { medium: "300x300", thumb: "100x100" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  	validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]
  	validates :image, :presence => true
end
