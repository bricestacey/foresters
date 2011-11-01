require 'csv'

namespace :tiara do
  task :load_records => :environment do
    CSV.foreach(File.expand_path(ENV["FILE_PATH"]), headers: true) do |row|
      record = Record.create({
        claim_id: row['Death Claim Number'],
        name_last: row["Insured's Surname"],
        name_given: row["Given Name"],
        name_middle: row["Middle Name or Initial"],
        title: row["Title"],
        age_at_initiation: row["Age at Initiation"]
      })
      begin
        record.court = Court.find(row["Court # "])
        record.save
      rescue
      end
    end
  end
end
