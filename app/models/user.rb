class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :votes, dependent: :destroy
  has_many :upvoted_entries, through: :votes, source: :entries

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        if(auth.info.email)
          user.email = auth.info.email  
        else
          user.email="#{auth.uid}@krazykontest.com"
        end        
        user.name = auth.info.name
        user.password = Devise.friendly_token[0,20]
      end
  end

  #def admin?
  #  self.role == 'admin' || self.role=='Admin'
  #end
end
