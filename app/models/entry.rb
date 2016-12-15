class Entry < ActiveRecord::Base
  belongs_to :contest
  has_many :votes, dependent: :destroy
  belongs_to :user
  has_many :upvoted_users, through: :votes, source: :user

  validates :caption,:mobile,:email, :presence => true
  validates :mobile, :numericality =>  {:only_integer=>true, :message => ' is invalid.'}
  validates :mobile, length:{ minimum: 10 }

  scope :recent, -> {order("entries.created_at DESC")}

  	has_attached_file :image, styles: { medium: "300x300", thumb: "100x100" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  	validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]
  	validates :image, :presence => true
end
