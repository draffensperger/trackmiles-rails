class HomeController < ApplicationController
  skip_before_filter :ensure_login, only: [:index]
  
	def index
	end
	
	def about
	end
	
	def privacy	  
	end
	
	def terms	  
	end
	
	def apps    
  end
end
