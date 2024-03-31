class Public::OpeningsController < Public::PublicController
  def index
    @openings = Opening.active.pluck(:id, :title, :location, :opening_type)

    render json: @openings
  end

  def show
    @opening = Opening.find(params[:id])
  end
end
