class HomeController < ApplicationController
  skip_before_filter :ensure_login
  
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
  
  def howitworks    
  end
  
  def feedback    
  end
  
  def faq
  end
end
