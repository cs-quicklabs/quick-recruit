class Public::OpeningsController < Public::PublicController
  def index
    @openings = Opening.active.order(:role_id).pluck(:id, :title, :location, :opening_type)

    respond_to do |format|
      format.json { render json: @openings }
      format.html
    end
  end

  def show
    @opening = Opening.find(params[:id])
    respond_to do |format|
      format.json { render json: @opening }
      format.html
    end
  end
end
