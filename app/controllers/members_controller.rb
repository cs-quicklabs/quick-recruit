class MembersController < ApplicationController
  before_action :authenticate_user!

  def index
    @members = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    form = UserForm.new(User.new, params[:user])
    form.save!
    redirect_to members_path, notice: "New member was created successfully"
  end
end
