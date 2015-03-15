class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :currency
      t.date :start
      t.date :end

      t.timestamps
    end
  end
end
