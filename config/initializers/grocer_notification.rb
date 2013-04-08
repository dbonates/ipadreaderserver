Grocer::Notification.class_eval do
  attr_accessor :content
  def payload_hash
    aps_hash = { }
    aps_hash[:alert] = alert if alert
    aps_hash[:badge] = badge if badge
    aps_hash[:sound] = sound if sound
    aps_hash["content-available"] = content if content
    { aps: aps_hash }.merge(custom || { })
  end

private
  def validate_payload
    fail NoPayloadError unless alert||badge||content
  end
end
