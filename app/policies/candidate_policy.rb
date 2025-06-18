class CandidatePolicy < ApplicationPolicy
  def update_bucket?
    user.admin? or (user.recruiter? and (record.incomplete? or record.icebox?))
  end

  def update_status?
    return true unless user.interviewer?
  end

  def update_campaign?
    return true if (record.pipeline? and not user.interviewer?)
  end

  def update_joining?
    return true unless user.interviewer?
  end

  def update_recycle?
    return true unless user.interviewer?
  end

  def update_owner?
    user.admin?
  end

  def reject_and_icebox?
    return true unless user.interviewer?
  end

  def toggle_recycle?
    return true unless user.interviewer?
  end
end
