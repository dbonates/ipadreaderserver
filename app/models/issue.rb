class Issue < ActiveRecord::Base
  attr_accessible :free, :description, :cover, :name, :pdf, :product_identifier, :previews_attributes, :contents_attributes, :bigcover
  
  belongs_to :magazine
  has_many :previews
  has_many :contents
  
  accepts_nested_attributes_for :previews, allow_destroy: true
  accepts_nested_attributes_for :contents, allow_destroy: true

  mount_uploader :pdf, PdfUploader
  mount_uploader :cover, ImageUploader
  mount_uploader :bigcover, ImageUploader 

  validates :pdf, presence: true
  validates :cover, presence: true
  validates :bigcover, presence: true
  validates :name, presence: true
  validates :product_identifier, presence: true
  validates :product_identifier, uniqueness: true

  default_scope order("created_at DESC")
end
