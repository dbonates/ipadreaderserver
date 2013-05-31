class Notification < ActiveRecord::Base
  attr_accessible :text, :magazine_id

  belongs_to :magazine
end
