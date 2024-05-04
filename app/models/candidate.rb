class Candidate < ApplicationRecord
  belongs_to :role
  belongs_to :source
  belongs_to :opening
  belongs_to :user
  belongs_to :owner, class_name: "User", foreign_key: "owner_id", optional: true
  has_one_attached :resume, dependent: :destroy

  has_many :notes, as: :notable, dependent: :destroy
  has_many :events, as: :eventable, dependent: :destroy
  has_many :emails, dependent: :destroy

  validates :email, uniqueness: true

  enum bucket: { recent: 0, hot: 1, pipeline: 2, champions: 3, joinings: 4, icebox: 5, archive: 6, incomplete: 7, alumni: 8, employees: 9, contractors: 10 }

  enum :status, [:waiting_for_evaluation, :interview_to_be_scheduled, :first_round_scheduled, :second_round_scheduled, :hr_round_scheduled, :offer_to_be_made, :offer_made, :offer_accepted, :joined, :on_hold, :no_show, :not_contactable, :follow_up_needed, :not_interested, :rejected_in_screening, :rejected_in_first_round, :rejected_in_second_round, :rejected_in_hr_round, :offer_withdrawn, :offer_declined, :unqualified, :other, :irrelevant, :incomplete_profile, :moved_on]

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

  def self.query(params, includes = nil)
    return [] if params.empty?
    CandidateQuery.new(self.unscoped.includes(:role, :opening, :user), params).filter
  end

  def status_color
  end
end
