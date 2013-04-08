class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :name
      t.string :product_identifier
      t.string :cover
      t.string :pdf

      t.timestamps
    end
  end
end
