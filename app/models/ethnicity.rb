class Ethnicity < ActiveRecord::Base
  has_and_belongs_to_many :courts

  validates :name, presence: true
  before_destroy :ensure_no_courts

  private
  def ensure_no_courts
    return false unless courts.empty?
  end
end
