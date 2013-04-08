class PushToken < ActiveRecord::Base
  attr_accessible :token, :bundle_id
  belongs_to :magazine
end
