class Account::RolesController < ApplicationController
  before_action :set_role, only: %i[edit update destroy]

  def index
    @roles = Role.all
    @role = Role.new
  end

  def edit
  end

  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.turbo_stream {
          render turbo_stream: turbo_stream.prepend(:roles, partial: "account/roles/role", locals: { role: @role }) +
                               turbo_stream.replace(Role.new, partial: "account/roles/form", locals: { role: Role.new, message: "Role was created successfully." })
        }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(Role.new, partial: "account/roles/form", locals: { role: @role })
        }
      end
    end
  end

  def update
    respond_to do |format|
      if @role.update(role_params)
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(@role, partial: "account/roles/role", locals: { role: @role, messages: nil })
        }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(@role, template: "account/roles/edit", locals: { role: @role, messages: @role.errors.full_messages })
        }
      end
    end
  end

  def destroy
    @role.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@role) }
    end
  end

  private

  def set_role
    @role ||= Role.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def role_params
    params.require(:role).permit(:title)
  end
end
