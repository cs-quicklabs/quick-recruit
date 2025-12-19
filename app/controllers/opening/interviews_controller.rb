class Opening::InterviewsController < Opening::BaseController
  before_action :set_opening

  def index
    @interviewer_options = User.interviewers
  end
end
