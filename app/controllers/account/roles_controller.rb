class Account::RolesController < ApplicationController
  def index
    @roles = Role.all
    @role = Role.new
  end
end
