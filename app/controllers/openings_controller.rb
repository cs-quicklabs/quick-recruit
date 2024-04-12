class OpeningsController < BaseController
  before_action :set_opening, only: %i[show edit update destroy]

  def index
    @openings = Opening.all.order(active: :desc, created_at: :asc)

    fresh_when @openings
  end

  def create
    @opening = Opening.create(openings_params)
    @opening.save
    redirect_to openings_path, notice: "New opening was created successfully"
  end

  def new
    @opening = Opening.new
  end

  def show
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private

  def openings_params
    params.require(:opening).permit(:title)
  end

  def set_opening
    @opening ||= Opening.find(params[:id])
  end
end
