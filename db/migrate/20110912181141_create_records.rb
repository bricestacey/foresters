class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :claim_id
      t.references :court
      t.integer :age_at_initiation
      t.text :initiated_on_year
      t.text :initiated_on_month
      t.text :initiated_on_date
      t.text :died_on_year
      t.text :died_on_month
      t.text :died_on_date
      t.string :beneficiary_name
      t.text :suspended_on_year
      t.text :suspended_on_month
      t.text :suspended_on_date
      t.text :reinstated_on_year
      t.text :reinstated_on_month
      t.text :reinstated_on_date
      t.text :withdrawn_on_year
      t.text :withdrawn_on_month
      t.text :withdrawn_on_date
      t.references :transferred
      t.text :transferred_on_year
      t.text :transferred_on_month
      t.text :transferred_on_date
      t.text :paid_on_year
      t.text :paid_on_month
      t.text :paid_on_date
      t.integer :register_no
      t.string :birth_city
      t.string :birth_county
      t.string :birth_state
      t.string :birth_country
      t.text :notes

      t.timestamps
    end
    add_index :records, :court_id
    add_index :records, :transferred_id
  end
end
