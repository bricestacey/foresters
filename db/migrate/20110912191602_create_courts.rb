class CreateCourts < ActiveRecord::Migration
  def change
    create_table :courts do |t|
      t.text :name
      t.text :street
      t.text :town
      t.date :instituted_on
      t.string :gender
      t.string :closed_on
      t.text :notes

      t.timestamps
    end
  end
end
