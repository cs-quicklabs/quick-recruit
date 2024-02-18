class Candidate::TimelineController < Candidate::BaseController
  before_action :set_candidate, only: %i[index show edit update destroy]

  def index
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
