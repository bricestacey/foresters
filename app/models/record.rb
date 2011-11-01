class Record < ActiveRecord::Base
  belongs_to :court
#  belongs_to :transferred, :class_name => 'Court'

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

  delegate :last, to: 'names.last', prefix: :name, allow_nil: true
  delegate :first, to: 'names.last', prefix: :name, allow_nil: true
  delegate :middle, to: 'names.last', prefix: :name, allow_nil: true
  delegate :title, to: 'names.last', prefix: :name, allow_nil: true

  def initiated_on
    "#{initiated_on_year}/#{initiated_on_month}/#{initiated_on_date}"
  end
  def died_on
    "#{died_on_year}/#{died_on_month}/#{died_on_date}"
  end
  def suspended_on
    "#{suspended_on_year}/#{suspended_on_month}/#{suspended_on_date}"
  end
  def paid_on
    "#{paid_on_year}/#{paid_on_month}/#{paid_on_date}"
  end
  def reinstated_on
    "#{reinstated_on_year}/#{reinstated_on_month}/#{reinstated_on_date}"
  end
  def withdrawn_on
    "#{withdrawn_on_year}/#{withdrawn_on_month}/#{withdrawn_on_date}"
  end

  define_index do
    indexes names.first,  as: :name_first
    indexes names.middle, as: :name_middle
    indexes names.last,   as: :name_last
    indexes names.title,  as: :name_title
    indexes court.name,   as: :court_name, facet: true

    has court_id
    has names.id
    set_property :delta => true
  end
end
