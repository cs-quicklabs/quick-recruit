class Candidate::TimelineController < Candidate::BaseController
  def index
    @events = Event.includes(:eventable, :trackable, :user).where(eventable: @candidate).order(created_at: :desc).limit(50)

    fresh_when [@candidate] + @events
  end

  def show
    fresh_when @candidate
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
