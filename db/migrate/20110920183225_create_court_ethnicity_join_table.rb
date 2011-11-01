class CreateCourtEthnicityJoinTable < ActiveRecord::Migration
  def change
    create_table :courts_ethnicities, id: false do |t|
      t.integer :court_id
      t.integer :ethnicity_id
    end
  end
end
