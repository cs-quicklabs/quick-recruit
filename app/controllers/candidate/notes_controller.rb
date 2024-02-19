class Candidate::NotesController < Candidate::BaseController
  before_action :set_candidate, only: %i[index show edit update destroy]

  def index
    @notes = Note.where(notable: @candidate)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
