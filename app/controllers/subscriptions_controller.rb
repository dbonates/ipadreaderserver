class SubscriptionsController < ApplicationController
  before_filter :load_magazine, only:[:index, :new, :create]
  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.where(:magazine_id => params[:magazine_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscriptions }
    end
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/new
  # GET /subscriptions/new.json
  def new
    @subscription = Subscription.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/1/edit
  def edit
    @subscription = Subscription.find(params[:id])
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(params[:subscription])
    @subscription.magazine = @magazine
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: 'Assinatura criada com sucesso.' }
        format.json { render json: @subscription, status: :created, location: @subscription }
      else
        format.html { render action: "new" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.json
  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to @subscription, notice: 'Assinatura atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy 
   
    @subscription = Subscription.find(params[:id]) 
    
     mag_id = @subscription.magazine_id 
     
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url(:magazine_id => mag_id) }
      format.json { head :no_content }
    end
  end

  private
  def load_magazine
    @magazine = Magazine.find(params[:magazine_id])
  end
end
