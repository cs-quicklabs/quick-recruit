class Candidate::InterviewsController < Candidate::BaseController
  def index
    @interviewers = @candidate.opening.interviewers
  end
end
