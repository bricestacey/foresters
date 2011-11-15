class Transfer < ActiveRecord::Base
  belongs_to :court, touch: true
end
