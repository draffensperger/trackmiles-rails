class HomeController < ApplicationController
  skip_before_filter :ensure_login, only: [:index]
  
	def index
		
	end
end
