class CreatePreviews < ActiveRecord::Migration
  def change
    create_table :previews do |t|
      t.string :image
      t.integer :issue_id

      t.timestamps
    end
  end
end
