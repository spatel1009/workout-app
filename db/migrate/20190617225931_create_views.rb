class CreateViews < ActiveRecord::Migration[5.2]
  def change
    add_column :exercises, :count, :integer, default: 0

  end
end
