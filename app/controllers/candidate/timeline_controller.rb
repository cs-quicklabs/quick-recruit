class Candidate::TimelineController < Candidate::BaseController
  before_action :set_candidate, only: %i[index show edit update destroy]

  def index
    @events = Event.where(eventable: @candidate).order(created_at: :asc)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_candidate
    @candidate ||= Candidate.find(params[:candidate_id])
  end
end
