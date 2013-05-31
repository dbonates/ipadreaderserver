#encoding: utf-8
class Magazine < ActiveRecord::Base 
   
  auto_strip_attributes :apps_id, :name
                   
  # extend FriendlyId
  # friendly_id :name, use: :slugged   
  
  # validates :slug, uniqueness: true, presence: true
  
  # before_validation :generate_slug
  
  attr_accessible :apps_id, :name, :pem, :user_id, :shared_secret, :visible
  validates :apps_id, :presence=> :true
  validates :pem, :presence=> :true
  validates :shared_secret, :presence => :true
  validates :apps_id, :uniqueness => :true
  has_many :subscriptions
  has_many :issues
  has_many :notifications
  has_many :push_tokens
  belongs_to :user
  mount_uploader :pem, PemUploader
        
   def is_visible
      visible ? "Sim" : "Não"
   end
  
  def firstname
    self.name.match(/^([\w]+)/i )[1].titlecase # a handy bonus class method if you're storing the User's full name in a single field and want to grab just their first name. For example, call in the view via @user.firstname
  end 
  
end
