class CandidatePolicy < ApplicationPolicy
  def update_bucket?
    user.admin? or (user.recruiter? and record.incomplete?)
  end
end
