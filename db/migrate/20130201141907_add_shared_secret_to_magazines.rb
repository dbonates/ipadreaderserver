class AddSharedSecretToMagazines < ActiveRecord::Migration
  def change
    add_column :magazines, :shared_secret, :string
  end
end
