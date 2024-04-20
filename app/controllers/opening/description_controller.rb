class Opening::DescriptionController < Opening::BaseController
  before_action :set_opening

  def index
  end

  def show
  end

  def edit
  end

  def update
    @opening.update(opening_params)
    @opening.save
    redirect_to opening_description_index_path(@opening), notice: "Opening description was updated successfully"
  end

  private

  def opening_params
    params.require(:opening).permit(:description)
  end
end
