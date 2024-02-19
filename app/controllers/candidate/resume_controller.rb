class Candidate::ResumeController < Candidate::BaseController
  before_action :set_candidate, only: %i[index show edit update destroy]
end
