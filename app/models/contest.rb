class Contest < ActiveRecord::Base
	has_many :entries, :dependent => :destroy

	validates :title,:description,:steps, :presence => true
	#validates :status, uniqueness:{scope: :contest_type}
	#validates :registration_number, length: { is: 6 }
	validates_uniqueness_of :contest_type, if: :same_status?
    
    def same_status?
     status == "active" || status="Active"
    end

	has_attached_file :image, styles: { medium: "300x300", thumb: "100x100" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  	validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]
end
