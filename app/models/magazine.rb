class Magazine < ActiveRecord::Base
  attr_accessible :apps_id, :name, :pem, :user_id, :shared_secret
  validates :apps_id, :presence=> :true
  validates :pem, :presence=> :true
  validates :shared_secret, :presence => :true
  validates :apps_id, :uniqueness => :true
  has_many :subscriptions
  has_many :issues
  has_many :push_tokens
  belongs_to :user
  mount_uploader :pem, PemUploader
end
