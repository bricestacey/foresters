# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

Court.delete_all

CSV.foreach(File.join(Rails.root, 'db', 'courts.csv'), headers: true) do |row|
  court = Court.create({id: row['id'], 
                name: row['name'], 
                town: row['town'], 
                street: row['street'],
                instituted_on: row['instituted_on'].nil? ? nil : Date.strptime(row['instituted_on'], '%m/%d/%Y'),
                gender: row['gender'],
                closed_on: row['closed_on'],
                notes: row['notes']
               })
  ethnicities = row['ethnicities'].split(', ').map {|e| Ethnicity.find_or_create_by_name(e)} if row[6]
  court.ethnicities << ethnicities unless ethnicities.nil?
end
