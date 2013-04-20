class Magazine < ActiveRecord::Base 
                    
  # validates :slug, uniqueness: true, presence: true
  
  # before_validation :generate_slug
  
  attr_accessible :apps_id, :name, :pem, :user_id, :shared_secret, :visible
  validates :apps_id, :presence=> :true
  validates :pem, :presence=> :true
  validates :shared_secret, :presence => :true
  validates :apps_id, :uniqueness => :true
  has_many :subscriptions
  has_many :issues
  has_many :push_tokens
  belongs_to :user
  mount_uploader :pem, PemUploader
  
  # def to_param
  #   slug
  #   # "#{id}-#{name}".parameterize
  # end 
  # 
  # def generate_slug
  #   self.slug ||= name.parameterize
  # end 
  
end
