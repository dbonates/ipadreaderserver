class AddUserIdToMagazine < ActiveRecord::Migration
  def change
    add_column :magazines, :user_id, :integer
  end
end
