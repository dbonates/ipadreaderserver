class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.string :product_identifier
      t.integer :magazine_id

      t.timestamps
    end
  end
end
