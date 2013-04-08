class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :text
      t.string :pages
      t.integer :issue_id

      t.timestamps
    end
  end
end
