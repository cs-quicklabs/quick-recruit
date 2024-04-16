class Opening < ApplicationRecord
  belongs_to :role
  scope :active, -> { where(active: true) }

  enum opening_type: { full_time: 0, part_time: 1, contract: 2 }
  enum priority: { p3: 0, p2: 1, p1: 2, u: 3 }
end
