class CreateBeneficiaries < ActiveRecord::Migration
  def change
    create_table :beneficiaries do |t|
      t.text       :name
      t.text       :relationship
      t.references :record

      t.timestamps
    end
    add_index :beneficiaries, :record_id
  end
end
