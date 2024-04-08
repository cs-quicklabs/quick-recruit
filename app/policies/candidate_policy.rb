class CandidatePolicy < ApplicationPolicy
  def update_bucket?
    user.admin? or (user.recruiter? and (record.incomplete? or record.icebox?))
  end

  def update_status?
    return true unless user.interviewer?
  end

  def update_owner?
    user.admin?
  end
end
