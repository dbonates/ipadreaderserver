class AddBigCoverToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :bigcover, :string
  end
end
