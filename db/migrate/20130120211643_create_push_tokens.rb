class CreatePushTokens < ActiveRecord::Migration
  def change
    create_table :push_tokens do |t|
      t.string :token
      t.integer :magazine_id

      t.timestamps
    end
  end
end
