class SessionsController < ApplicationController

    def new 
    end

    def create 
        if user = User.authenticate_by(email: params[:email], password: params[:password])
            login user
            redirect_to root_path, notice: "You have been logged in."
        else
            flash.now[:alert] = "Your email or password is incorrect."
            render :new, status: :unprocessible_entity
        end
    end

    def destroy 
        logout current_user
        redirect_to new_session_path, notice: "You have been logged out."
    end
end