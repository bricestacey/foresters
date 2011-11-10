class AddNotesPrivateToRecords < ActiveRecord::Migration
  def change
    add_column :records, :notes_private, :text
  end
end
