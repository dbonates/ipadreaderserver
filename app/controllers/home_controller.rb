class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  
	def index
    if current_user.present? 
      
      redirect_to magazines_path
      
    end
  end

end