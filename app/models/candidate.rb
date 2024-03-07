class Candidate < ApplicationRecord
  belongs_to :role
  belongs_to :source
  belongs_to :opening
  belongs_to :user
  has_one_attached :resume, dependent: :destroy

  has_many :notes, as: :notable, dependent: :destroy
  has_many :events, as: :eventable, dependent: :destroy

  validates :email, uniqueness: true

  enum bucket: { recent: 0, hot: 1, pipeline: 2, champions: 3, joinings: 4, icebox: 5, archive: 6, incomplete: 7 }

  default_scope { order(created_at: :desc) }

  def name
    first_name + " " + last_name
  end

  def age
    if birth_year.nil?
      "-"
    else
      (Date.today.year - birth_year).to_formatted_s + " years"
    end
  end
end
