class Name < ActiveRecord::Base
  belongs_to :record, touch: true
end
