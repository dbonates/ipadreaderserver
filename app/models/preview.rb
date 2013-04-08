class Preview < ActiveRecord::Base
  attr_accessible :image, :issue_id
  belongs_to :issue
  mount_uploader :image, ImageUploader
end
