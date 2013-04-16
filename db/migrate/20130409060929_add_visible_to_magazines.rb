class AddVisibleToMagazines < ActiveRecord::Migration
  def change
    add_column :magazines, :visible, :boolean
  end
end
