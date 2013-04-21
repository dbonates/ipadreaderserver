class Magazine < ActiveRecord::Base 
                    
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
  has_many :push_tokens
  belongs_to :user
  mount_uploader :pem, PemUploader
  
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
