class Opening::BaseController < ApplicationController
  before_action :authenticate_user!

  private

  def set_opening
    @opening ||= Opening.find(params[:id])
  end
end
