class User < ActiveRecord::Base  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
         
  has_many :location

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  	:provider, :uid, :name
  # attr_accessible :title, :body
  
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
        user = User.create(name: data["name"],
	    		   email: data["email"],
	    		   password: Devise.friendly_token[0,20]
	    		  )
    end
    user
  end
  
  def self.find_or_create_for_auth_token(provider, uid, token)
    userinfo = get_userinfo_for_auth_token(provider, uid, token)
    find_or_create_for_userinfo(provider, uid, userinfo)
  end
  
  def self.find_or_create_for_userinfo(provider, uid, userinfo)
    if userinfo.nil? 
      return nil
    end
    
    user = User.where(:uid => uid).first
    unless user
      user = User.create(
        name: userinfo["name"], 
        email: userinfo["email"],
        provider: provider,
        uid: uid,
        password: Devise.friendly_token[0,20]
        )
    end
    user
  end
  
  def self.get_userinfo_for_auth_token(provider, uid, token)
    if provider == "google"
      userinfo_url = "https://www.googleapis.com/oauth2/v1/userinfo"
      
      begin
        RestClient.get userinfo_url, :params => {:access_token => token}
      rescue Exception => e
        nil
      end
    end        
  end
end
