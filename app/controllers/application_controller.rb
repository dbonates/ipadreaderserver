#encoding: utf-8
class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  
  def validate_admin!
    if !current_user
      return
    end
    
    if !current_user.admin? 
        
          @magazines = Magazine.where(user_id: current_user.id)
      
          if @magazines
             @magazine = @magazines.first
             
             if @magazine
               redirect_to @magazine
             else
               no_magazine_for_you!
             end
          else
            no_magazine_for_you!
          end 
   end
    
  end
  
  def no_magazine_for_you!
    sign_out current_user
    redirect_to root_path, notice: 'Nenhuma Publicação para este usuario. Solicitar cadastro para sua Publicação.'
  end
  
  protect_from_forgery
  
  
end
