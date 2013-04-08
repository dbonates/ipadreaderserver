class IssueObserver < ActiveRecord::Observer

  def configurate_pusher(magazine, sandbox=nil)
    gateway = sandbox ? "gateway.sandbox.push.apple.com" : "gateway.push.apple.com"
    cert = sandbox ? "/srv/basispress.com/ipadreaderserver/public/cert.pem" : magazine.pem.path
    Grocer.pusher(certificate:cert, gateway:gateway)
  end

  def after_create(issue)
    magazine = issue.magazine
    pusher = configurate_pusher(magazine)
#    pusher_sandbox = configurate_pusher(magazine, true)
    tokens = PushToken.where(:magazine_id => magazine.id).pluck(:token)

    notifications = []
    tokens.each do |token|
      notifications << Grocer::Notification.new(device_token:token, content:1)
    end

    notifications.each do |notification|
      pusher.push(notification)
#      pusher_sandbox.push(notification)
    end
  end
end
