class Candidate < ApplicationRecord
  has_one :role
  has_one :source
  belongs_to :opening
  has_one_attached :resume, dependent: :destroy

  has_many :notes, as: :notable, dependent: :destroy
  has_many :events, as: :eventable, dependent: :destroy

  enum bucket: { recent: 0, hot: 1, pipeline: 2, champions: 3, joinings: 4, icebox: 5, archive: 6, incomplete: 7 }

  def name
    first_name + " " + last_name
  end
end
