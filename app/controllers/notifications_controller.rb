#encoding: utf-8
class NotificationsController < ApplicationController
  
  def index
  end

  def show
    redirect_to notifications_path
  end

  def new
  end

  def create
    if notification.save
      flash[:notice] = "Notificação criada..."
      redirect_to notifications_path(:magazine_id => notification.magazine_id)
    else
      flash[:notice] = "Erro ao criar"
      render 'new'
    end
  end

  def edit
  end

  def update
    if notification.update_attributes(params[:notification])
      flash[:notice] = "Atualizado com sucesso."
      redirect_to notifications_path(:magazine_id => notification.magazine_id)
    else
      flash[:notice] = "Erro ao atualizar"
      render 'edit'
    end
  end

  def destroy
    if notification.destroy
      flash[:notice] = "Notificação removida"
      redirect_to notifications_path(:magazine_id => notification.magazine_id)
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
      redirect_to notifications_path(:magazine_id => notification.magazine_id)
      end

  end

  # 
  #  metodos privados
  # 
  
  helper_method :current_magazine
  def current_magazine
    @current_magazine ||= params[:magazine_id] ? Magazine.find_by_id(params[:magazine_id]) : Magazine.find_by_id(notification.magazine_id)
  end

  private

  def notifications
    @notifications ||=  Notification.where(:magazine_id => current_magazine.id)
  end
  helper_method :notifications


  def notification
    @notification ||= params[:id] ? Notification.find(params[:id]) : Notification.new(params[:notification])
  end
  helper_method :notification

end
