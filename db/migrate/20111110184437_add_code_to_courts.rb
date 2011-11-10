class AddCodeToCourts < ActiveRecord::Migration
  def change
    add_column :courts, :code, :text

    Court.all.each do |court|
      court.code = court.id
      court.save!
    end
  end
end
