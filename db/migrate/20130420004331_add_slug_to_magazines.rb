class AddSlugToMagazines < ActiveRecord::Migration
  def change
    add_column :magazines, :slug, :string
    add_index :magazines, :slug, unique: true
  end
end
