class OpeningPolicy < ApplicationPolicy
  def show?
    user.admin? or user.recruiter? or user.recruiter_admin?
  end

  def edit?
    user.admin? or user.recruiter_admin?
  end

  def update?
    user.admin? or user.recruiter_admin?
  end

  def index?
    true
  end

  def create?
    user.admin? or user.recruiter_admin?
  end
end
