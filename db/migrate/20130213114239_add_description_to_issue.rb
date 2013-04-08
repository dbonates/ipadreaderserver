class AddDescriptionToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :description, :text
  end
end
