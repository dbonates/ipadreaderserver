#encoding: utf-8
class MagazinesController < ApplicationController
  
  before_filter :validate_admin!, only: [:index, :new, :create]
             
  before_filter :find_magazine, only: [:show, :edit, :update, :destroy]
  
  
  def find_magazine
     @magazine = Magazine.find_by_slug(params[:id])       
    # if current_user.admin
    #       # @magazine = Magazine.includes(:issues, :subscriptions).where(:id => params[:id]).first
    #       # magazines = Magazine.includes(:issues, :subscriptions).where(:id => params[:id])
    #       @magazine = Magazine.find(params[:id])  
    #     else
    #       @magazine = Magazine.includes(:issues, :subscriptions).where(:user_id => current_user.id).find(params[:id]) 
    #     end   
    
  end
  
  
  # GET /magazines
  # GET /magazines.json
  def index
        
    if current_user.admin
      @magazines = Magazine.all
    else
       @magazines =  Magazine.where(:user_id => current_user.id)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @magazines }
    end
  end

  # GET /magazines/1
  # GET /magazines/1.json
  def show
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @magazine }
    end
  end

  # GET /magazines/new
  # GET /magazines/new.json
  def new
    @magazine = Magazine.new(:user_id => current_user.id)
    
    @users = User.order("id ASC")

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @magazine }
    end
  end

  # GET /magazines/1/edit
  def edit
    @users = User.order("id ASC") 
    
  end

  # POST /magazines
  # POST /magazines.json
  def create
    @magazine = Magazine.new(params[:magazine])
    @magazine.user = current_user
    respond_to do |format|
      if @magazine.save
        format.html { redirect_to magazine_path(@magazine), notice: 'Publicação criada com sucesso.' }
        format.json { render json: @magazine, status: :created, location: @magazine }
      else
        format.html { render action: "new" }
        format.json { render json: @magazine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /magazines/1
  # PUT /magazines/1.json
  def update
    # if current_user.admin
    #       @magazine = Magazine.find_by_id(params[:id])
    #     else
    #       @magazine = Magazine.where(:user_id => current_user.id).find_by_id(params[:id]) 
    #     end 
    
    # @magazine = Magazine.where(:user_id => current_user.id).find(params[:id])

    respond_to do |format|
      if @magazine.update_attributes(params[:magazine])
        format.html { redirect_to magazines_path, notice: 'Publicação atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @magazine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /magazines/1
  # DELETE /magazines/1.json
  def destroy
    # @magazine = Magazine.where(:user_id => current_user.id).find(params[:id])
    @magazine.destroy

    respond_to do |format|
      format.html { redirect_to magazines_url }
      format.json { head :no_content }
    end
  end
end
