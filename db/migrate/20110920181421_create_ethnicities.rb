class CreateEthnicities < ActiveRecord::Migration
  def change
    create_table :ethnicities do |t|
      t.text :name
      t.references :court

      t.timestamps
    end
  end
end
