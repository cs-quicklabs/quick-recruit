class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]

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

  def new
    @candidate = Candidate.new
    @roles = Role.all
    @openings = Opening.all
    @sources = Source.all
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to new_candidate_path, notice: "New candidate was created successfully"
    else
      redirect_to new_candidate_path, alret: "New candidate was not created successfully"
    end
  end

  def recent
    @candidates = Candidate.all
  end

  def hot
  end

  def pipeline
  end

  def champions
  end

  def joinings
  end

  def icebox
  end

  def archive
  end

  def incomplete
  end

  private

  def candidate_params
    params.require(:candidate).permit(:first_name, :last_name, :email, :phone, :location, :biography, :facebook, :role_id, :source_id, :opening_id, :linkedin, :github, :twitter, :portfolio, :website, :current_ctc, :expected_ctc, :current_company, :current_title, :notice_period, :experience, :birth_year, :highest_qualification, :bucket, :resume)
  end

  def set_candidate
    @candidate ||= Candidate.find(params[:id])
  end
end
