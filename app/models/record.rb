class Record < ActiveRecord::Base
  belongs_to :court

  has_one :residence, :class_name => 'Address'
  accepts_nested_attributes_for :residence

  has_many :names
  accepts_nested_attributes_for :names, :allow_destroy => :true,
      :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  has_many :transfers
  accepts_nested_attributes_for :transfers, :allow_destroy => :true,
      :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  has_many :beneficiaries
  accepts_nested_attributes_for :beneficiaries, :allow_destroy => :true,
      :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  delegate :name, to: :court, prefix: true, allow_nil: true
  delegate :city, to: :residence, prefix: true, allow_nil: true

  delegate :last, to: 'names.last', prefix: :name, allow_nil: true
  delegate :first, to: 'names.last', prefix: :name, allow_nil: true
  delegate :middle, to: 'names.last', prefix: :name, allow_nil: true
  delegate :title, to: 'names.last', prefix: :name, allow_nil: true

  def initiated_on
    [initiated_on_year, initiated_on_month, initiated_on_date].delete_if(&:blank?).join('/')
  end
  def died_on
    [died_on_year, died_on_month, died_on_date].delete_if(&:blank?).join('/')
  end
  def suspended_on
    [suspended_on_year, suspended_on_month, suspended_on_date].delete_if(&:blank?).join('/')
  end
  def paid_on
    [paid_on_year, paid_on_month, paid_on_date].delete_if(&:blank?).join('/')
  end
  def reinstated_on
    [reinstated_on_year, reinstated_on_month, reinstated_on_date].delete_if(&:blank?).join('/')
  end
  def withdrawn_on
    [withdrawn_on_year, withdrawn_on_month, withdrawn_on_date].delete_if(&:blank?).join('/')
  end

  # THINKING SPHINX

  # These are the indexes you may search on. The first element of an array is 
  # the label in the drop down. The second is the name of the sphinx index.
  SEARCH_INDEXES = [
    ['Keywords', 'keyword'], 
    ['First Name', 'name_first'],
    ['Middle Name', 'name_middle'],
    ['Last Name', 'name_last']
  ]

  define_index do
    indexes names.first,    as: :name_first,     sortable: true
    indexes names.middle,   as: :name_middle,    sortable: true
    indexes names.last,     as: :name_last,      sortable: true
    indexes names.title,    as: :name_title,     sortable: true
    indexes court.name,     as: :court_name,     sortable: true, facet: true
    indexes residence.city, as: :residence_city, sortable: true, facet: true
    indexes died_on_year,   as: :died_on_year,   sortable: true, facet: true

    has claim_id,           as: :claim_id, sortable: true
    has court_id
    has names.id
    set_property :delta => true
  end
end
