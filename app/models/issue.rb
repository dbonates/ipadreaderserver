#encoding: utf-8  
class Issue < ActiveRecord::Base
  # extend FriendlyId
  # friendly_id :name, use: :slugged              
  default_scope order('position ASC')

  auto_strip_attributes :product_identifier, :name 
  
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
             
  def is_visible
      visible ? "Sim" : "Não"
  end
   
  def is_free
       free ? "Sim" : "Não"
  end
    
    
  def slug
     "#{id}-#{name}".parameterize
   end

  def to_param
    slug
  end

  def self.find_by_slug(*args)
    record = find(*args)
    if record and record.respond_to? :slug
      return nil unless record.slug == args.first
    end
    record
  end

  def self.find_by_slug!(*args)
    find_by_slug(*args) or raise ActiveRecord::RecordNotFound
  end
  
  def firstname
    self.name.match(/^([\w]+)/i )[1].titlecase # a handy bonus class method if you're storing the User's full name in a single field and want to grab just their first name. For example, call in the view via @user.firstname
  end
  
end
