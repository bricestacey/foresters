class Beneficiary < ActiveRecord::Base
  belongs_to :record, touch: true
end
