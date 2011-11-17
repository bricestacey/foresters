# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

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

Record.suspended_delta do
  CSV.foreach(File.join(Rails.root, 'db', 'records.csv'), headers: true) do |row|
    record = Record.create!({
      claim_id: row['Death Claim Number'],
      age_at_initiation: row['Age at Initiation'],
      notes_private: "Missing: #{row['Missing']}"
    }.tap do |attributes|
      if row['Text Form Initiation date (for sorting)']
        attributes[:initiated_on_year]  = row['Text Form Initiation date (for sorting)'][0..3]
        attributes[:initiated_on_month] = row['Text Form Initiation date (for sorting)'][4..5]
        attributes[:initiated_on_date]  = row['Text Form Initiation date (for sorting)'][6..7]
      end
      if row['Text Form Death Date (for sorting)']
        attributes[:died_on_year]  = row['Text Form Death Date (for sorting)'][0..3]
        attributes[:died_on_month] = row['Text Form Death Date (for sorting)'][4..5]
        attributes[:died_on_date]  = row['Text Form Death Date (for sorting)'][6..7]
      end
    end)

    record.names.create!({
      last: row["Insured's Surname"],
      first: row["Given Name"],
      middle: row['Middle Name or Initial'],
      title: row['Title'],
    })

    record.court = Court.find_by_code(row['Court #'])
    raise if record.court.nil?
  end
end
