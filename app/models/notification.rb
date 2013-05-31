class Notification < ActiveRecord::Base
  attr_accessible :text, :magazine_id, :enviada_em

  belongs_to :magazine
end
