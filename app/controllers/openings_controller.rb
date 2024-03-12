class OpeningsController < BaseController
  def index
    @openings = Opening.all

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

  private

  def openings_params
    params.require(:opening).permit(:title)
  end
end
