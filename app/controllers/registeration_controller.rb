class RegisterationController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(registeration_params)
    if @user.save
      login @user
      redirect_to root_path, notice: "You have been registered."
    else
      render :new, status: :unprocessible_entity
    end
  end

  private

  def registeration_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
