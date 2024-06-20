class Recycle < ApplicationRecord
  belongs_to :candidate

  validates :candidate, uniqueness: true
end
