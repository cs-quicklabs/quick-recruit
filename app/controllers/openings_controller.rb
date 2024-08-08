class OpeningsController < BaseController
  before_action :set_opening, only: %i[show edit update destroy]

  def index
    @openings = nil
    if current_user.admin?
      if params[:active].present?
        @openings = Opening.includes(:role, :owner).where(active: params[:active]).order(active: :desc, role_id: :desc, created_at: :asc)
      else
        @openings = Opening.includes(:role, :owner).all.order(active: :desc, role_id: :desc, created_at: :asc)
      end
    else
      @openings = Opening.includes(:role, :owner).where(owner: current_user, active: true).order(active: :desc, role_id: :desc, created_at: :asc)
    end

    fresh_when @openings
  end

  def create
    @opening = Opening.create(openings_params)
    @opening.save
    redirect_to openings_path, notice: "New opening was created successfully"
  end

  def new
    @opening = Opening.new
    @roles = Role.all
  end

  def show
  end

  def update
    @opening.update(openings_params)
    redirect_to opening_path(@opening), notice: "Opening was updated successfully"
  end

  def edit
    @roles = Role.all.order(title: :asc)
  end

  def destroy
  end

  private

  def openings_params
    params.require(:opening).permit(:title, :role_id, :active, :priority, :owner_id, :resume_screening_checklist, :telephonic_screening_checklist, :first_round_score, :second_round_score, :hr_round_score)
  end

  def set_opening
    @opening ||= Opening.find(params[:id])
  end
end
