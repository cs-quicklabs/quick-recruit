class Candidate::ResumeController < Candidate::BaseController
  before_action :set_candidate, only: %i[create index show edit update destroy]

  def index
  end

  def show
  end

  def update
  end

  def create
    @candidate.update(candidate_params)
    Event.new(eventable: @candidate, action: "upload_resume", action_for_context: "uploaded resume", trackable: @candidate, user: current_user).save
    redirect_to candidate_timeline_path(@candidate), notice: "Resume was uploaded successfully", status: :see_other
  end

  def destroy
    @candidate.resume.purge
    Event.new(eventable: @candidate, action: "delete_resume", action_for_context: "deleted resume", trackable: @candidate, user: current_user).save
    redirect_to candidate_timeline_path(@candidate), alert: "Resume was deleted successfully", status: :see_other
  end

  private

  def candidate_params
    params.require(:candidate).permit(:resume)
  end

  def set_candidate
    @candidate ||= Candidate.find(params[:candidate_id])
  end
end
