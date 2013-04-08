class Subscription < ActiveRecord::Base
  attr_accessible :magazine_id, :name, :product_identifier
  belongs_to :magazine
end
