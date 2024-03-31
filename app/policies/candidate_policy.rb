class CandidatePolicy < ApplicationPolicy
  def update_bucket?
    user.admin? or (user.recruiter? and record.incomplete?)
  end

  def update_status?
    return true unless user.interviewer?
  end
end
