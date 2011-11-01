class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.references :record
      t.references :court
      t.text :transferred_on_year
      t.text :transferred_on_month
      t.text :transferred_on_date

      t.timestamps
    end
    add_index :transfers, :court_id
  end
end
