#encoding: utf-8
class NotificationsController < ApplicationController
  
  before_filter :find_magazine
  before_filter :find_notification
 


  def index
    # if current_user.admin
    #   @notifications = Notification.all
    # else
      @notifications =  Notification.where(:magazine_id => @magazine.id)
    # end
    
  end

  def show
    redirect_to notifications_path(@notification.magazine_id)
  end

  def new
  end

  def create
    if @notification.save
      flash[:notice] = "Notificação criada..."
      redirect_to notifications_path(@notification.magazine_id)
    else
      flash[:notice] = "Erro ao criar"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @notification.update_attributes(params[:notification])
      flash[:notice] = "Atualizado com sucesso."
      redirect_to notifications_path(@notification.magazine_id)
    else
      flash[:notice] = "Erro ao atualizar"
      render 'edit'
    end
  end

  def destroy
    if @notification.destroy
      flash[:notice] = "Notificação removida"
      redirect_to notifications_path(@notification.magazine_id)
    end
  end

  def send_push
    notificacao = Notification.find_by_id(params[:id])
    if notificacao
      magazine = Magazine.first
      pusher = Grocer.pusher(
        certificate: magazine.pem.path,      # required
        passphrase:  "sdtl2302",                       # optional
        # mudar quando for para ambiente de produção
        gateway:     "gateway.sandbox.push.apple.com", # optional; See note below.
        port:        2195,                     # optional
        retries:     3                         # optional
      )

      tokens = PushToken.where(:magazine_id => magazine.id).pluck(:token)

      mensagem = notificacao.text

      notifications = []
      tokens.each do |token|
        notifications << Grocer::Notification.new(
        device_token: token,
        alert:        mensagem,
      )
      end

      notifications.each do |notification|
        pusher.push(notification)
      end
      totalTokens = tokens.size
      flash[:notice] = "Notificação enviada para #{totalTokens} iPads. (texto:#{mensagem})"
      redirect_to notifications_path(:format => notificacao.magazine_id)
      end

  end

  # 
  #  metodos privados
  # 

  private

  def find_notification
    @notification ||= params[:id] ? Notification.find(params[:id]) : Notification.new(params[:notification]) #:magazine_id => @magazine.id)
  end

  def find_magazine
    # array = current_user.admin ? Magazine.where(:id => params[:id]) : Magazine.where(:user_id => current_user.id)
    @magazine = params[:format] ? Magazine.find_by_id(params[:format]) : Magazine.find_by_id(params[:magazine_id])
  end
  


end
