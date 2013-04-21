class Subscription < ActiveRecord::Base
  attr_accessible :magazine_id, :name, :product_identifier
  belongs_to :magazine
  
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
