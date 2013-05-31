class AddMagazineIdToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :magazine_id, :integer
  end
end
