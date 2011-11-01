class AddSphinxDeltaIndexes < ActiveRecord::Migration
  def up
    add_column :records, :delta, :boolean, :default => true, :null => false
  end

  def down
    remove_column :records, :delta
  end
end
