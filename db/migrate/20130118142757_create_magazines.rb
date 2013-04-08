class CreateMagazines < ActiveRecord::Migration
  def change
    create_table :magazines do |t|
      t.string :name
      t.string :apps_id
      t.string :pem

      t.timestamps
    end
  end
end
