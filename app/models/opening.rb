class Opening < ApplicationRecord
  scope :active, -> { where(active: true) }

  enum opening_type: { full_time: 0, part_time: 1, contract: 2 }
end
