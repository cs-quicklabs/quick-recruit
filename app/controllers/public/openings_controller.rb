class Public::OpeningsController < Public::PublicController
  def index
    @openings = Opening.active.pluck(:id, :title, :location, :opening_type)

    respond_to do |format|
      format.json { render json: @openings }
      format.html
    end
  end

  def show
    @opening = Opening.find(params[:id])
  end
end
