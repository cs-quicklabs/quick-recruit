class Opening::NoteController < Opening::BaseController
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
    redirect_to opening_note_index_path(@opening), notice: "Internal note was updated successfully"
  end

  private

  def opening_params
    params.require(:opening).permit(:note)
  end
end
