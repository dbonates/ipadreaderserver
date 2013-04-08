class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  
	def index
    if current_user.present? 
      
      if params[:show_all]
        if params[:show_all] == true
          redirect_to magazines_path 
        end
      
      else
      
        @user_magazine = Magazine.where(:user_id => current_user.id).first
        redirect_to(magazine_path(@user_magazine))      
        #redirect_to(magazine_issues_path(@user_magazine))      
      
      end
      
      
    end
  end

end