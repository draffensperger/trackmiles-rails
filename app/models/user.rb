class User < ActiveRecord::Base  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
         
  has_many :locations
  
  validates_associated :locations

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  	:provider, :uid, :name
  # attr_accessible :title, :body
  
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    find_or_create_for_google_userinfo(access_token.info)
  end
  
  def self.find_or_create_for_google_token(token)
    find_or_create_for_google_userinfo(get_userinfo_for_google_token(token))
  end
  
  def self.find_or_create_for_google_userinfo(userinfo)
    if userinfo.nil? or not userinfo.has_key?("email") or 
      userinfo["email"].nil? or userinfo["email"] == "" 
      
      return nil
    end
    
    user = User.where(:email => userinfo["email"]).first
    unless user
      user = User.create(
        name: userinfo["name"], 
        email: userinfo["email"],
        provider: 'google',
        password: Devise.friendly_token[0,20]
        )
    end
    user
  end
  
  def self.get_userinfo_for_google_token(token)  
    url = "https://www.googleapis.com/oauth2/v1/userinfo"
    
    begin
      JSON.parse RestClient.get url, :params => {:access_token => token}      
    rescue RestClient::Unauthorized
      nil
    rescue => e
      # Other exceptions e.g. network problems will also cause a return of nil.
      nil
    end        
  end
end
