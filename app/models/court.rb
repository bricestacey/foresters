class Court < ActiveRecord::Base
  has_and_belongs_to_many :ethnicities
  has_many :records 

  validates :gender, inclusion: {in: %(Men Women Mixed)}, allow_nil: true

  before_destroy :ensure_no_records 

  def to_s
    "#{id} - #{name}"
  end

  define_index do
    indexes name, sortable: true
    indexes street
    indexes town, sortable: true, facet: true
    indexes gender, sortable: true
    indexes notes
    indexes closed_on
    indexes instituted_on
  end

  private
  def ensure_no_records
    return false unless records.empty?
  end
end
