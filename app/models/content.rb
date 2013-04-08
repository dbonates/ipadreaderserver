class Content < ActiveRecord::Base
  attr_accessible :issue_id, :pages, :text
  belongs_to :issue
end
