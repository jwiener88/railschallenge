class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.integer :aptid
      t.date :checkin
      t.date :checkout
      t.boolean :availability

      t.timestamps
    end
  end
end
