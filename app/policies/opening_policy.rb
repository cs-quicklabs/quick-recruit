class OpeningPolicy < ApplicationPolicy
  def show?
    user.recruiter? or user.admin_or_recruiter_admin?
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
end
