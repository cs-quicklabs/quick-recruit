class Candidate::BaseController < BaseController
  before_action :authenticate_user!
  before_action :set_candidate

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
