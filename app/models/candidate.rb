class Candidate < ApplicationRecord
  has_one :role
  has_one :source
  has_one :opening
  has_one_attached :resume, dependent: :destroy

  enum bucket: { recent: 0, hot: 1, pipeline: 2, champions: 3, joinings: 4, icebox: 5, archive: 6, incomplete: 7 }
end
