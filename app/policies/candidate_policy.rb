class CandidatePolicy < ApplicationPolicy
  def update_bucket?
    user.admin?
  end
end
