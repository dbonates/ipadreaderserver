class AddFreeToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :free, :boolean
  end
end
