class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :record
      t.text :line1
      t.text :line2
      t.text :city
      t.text :state
      t.text :zip

      t.timestamps
    end
  end
end
