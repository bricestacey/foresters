class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.text :first
      t.text :middle
      t.text :last
      t.text :title
      t.references :record

      t.timestamps
    end
    add_index :names, :record_id
  end
end
