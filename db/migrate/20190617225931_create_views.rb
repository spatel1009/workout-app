class CreateViews < ActiveRecord::Migration[5.2]
  def change
    create_table :views do |t|
      t.integer :count, default: 0
      t.references :exercise, foreign_key: true

      t.timestamps
    end
  end
end
