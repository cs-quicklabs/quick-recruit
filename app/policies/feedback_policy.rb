class FeedbackPolicy < ApplicationPolicy
  def show?
    user.admin_or_recruiter_admin? or (record.user == user)
  end

  def edit?
    user.admin_or_recruiter_admin?
  end

  def update?
    user.admin_or_recruiter_admin?
  end

  def index?
    true
  end

  def create?
    user.admin_or_recruiter_admin?
  end

  def destroy?
    user.admin_or_recruiter_admin?
  end
end
