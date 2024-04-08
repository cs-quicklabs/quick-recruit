class OpeningPolicy < ApplicationPolicy
  def show?
    user.admin? or user.recruiter?
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  def index?
    true
  end

  def create?
    user.admin?
  end
end
