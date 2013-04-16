class PushTokensController < ApplicationController
  skip_before_filter :authenticate_user!
  protect_from_forgery :except => :create 
  # GET /push_tokens
  # GET /push_tokens.json
  def index
    @magazine = Magazine.find_by_apps_id(params[:id])
    @push_tokens = PushToken.where(:magazine_id =>@magazine.id)
  end

  # POST /push_tokens
  # POST /push_tokens.json
  def create
    @magazine = Magazine.find_by_apps_id(params[:bundle_id])
    if @magazine
      @push_token = PushToken.find_or_create_by_token(Base64.decode64(params[:push_token][:token]).unpack("H*").first){|p| p.magazine = @magazine }
      respond_to do |format|
        if @push_token.save
          format.json { render json: @push_token, status: :created, location: @push_token }
        else
          format.json { render json: @push_token.errors, status: :unprocessable_entity }
        end
      end
    else
      render json: @push_token.errors, status: :unprocessable_entity
    end
  end
x
  # DELETE /push_tokens/1
  # DELETE /push_tokens/1.json
  def destroy
    @push_token = PushToken.find(params[:id])
    mag = @push_token.magazine
    @push_token.destroy

    respond_to do |format|
      format.html { redirect_to push_tokens_url(id:mag.apps_id) }
      format.json { head :no_content }
    end
  end
end
