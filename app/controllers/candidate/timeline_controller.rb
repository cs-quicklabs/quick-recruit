class Candidate::TimelineController < Candidate::BaseController
  def index
    @events = Event.where(eventable: @candidate).order(created_at: :desc).limit(50)
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
