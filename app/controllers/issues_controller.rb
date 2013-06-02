class IssuesController < ApplicationController
  
  before_filter :load_magazine, only:[:index, :new, :create]
  before_filter :find_issue, only: [:show, :edit, :update, :destroy]
  
  # GET /issues
  # GET /issues.json
  def index
    
    if current_user.admin && !@magazine
           @issues = Issue.order("position")
    else
           @issues = Issue.where(:magazine_id => @magazine.id).order("position")
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @magazine = Magazine.find_by_id(@issue.magazine_id) 
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/new
  # GET /issues/new.json
  def new
    @issue = Issue.new


    # @issue.position = Issue.where(:magazine_id => @magazine.id).count+1
    @issue.position = 0 # adicionando na ponta
    3.times{@issue.previews << Preview.new}
    3.times{@issue.contents << Content.new}
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /issues/1/edit
  def edit 
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(params[:issue])
    @issue.magazine = @magazine
    respond_to do |format|
      if @issue.save
        format.html { redirect_to magazine_issues_path(:magazine_id => @issue.magazine_id), notice: 'Edicao criada com sucesso.' }
        format.json { render json: @issue, status: :created, location: @issue }
      else
        format.html { render action: "new" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /issues/1
  # PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        format.html { redirect_to @issue, notice: 'Edicao atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    
    mag_id = @issue.magazine_id 
    
    
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to magazine_issues_path(:magazine_id => mag_id) }
      format.json { head :no_content }
    end
  end

  def sort
    params[:issue].each_with_index do |id, index|
      Issue.update_all({position: index+1}, {id: id})
    end
    render nothing: true
    
  end

  private             
  
    def find_issue
      @issue = Issue.find_by_slug(params[:id]) 
    end
  
    def load_magazine       
        @magazine = Magazine.find_by_id(params[:magazine_id])
    end
end
