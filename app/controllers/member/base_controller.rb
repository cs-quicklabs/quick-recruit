class Member::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :set_member

  private

  def set_member
    @member ||= User.find(params[:member_id])
  end
end
