class MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy]

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

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_user
    @user ||= User.find(params[:id])
  end
end
