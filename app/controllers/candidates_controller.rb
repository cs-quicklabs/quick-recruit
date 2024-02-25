class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]

  def index
    @recent_count = Candidate.where(bucket: :recent).count
    @hot_count = Candidate.where(bucket: :hot).count
    @pipeline_count = Candidate.where(bucket: :pipeline).count
    @champions_count = Candidate.where(bucket: :champions).count
    @joinings_count = Candidate.where(bucket: :joinings).count
    @icebox_count = Candidate.where(bucket: :icebox).count
    @archive_count = Candidate.where(bucket: :archive).count
    @incomplete_count = Candidate.where(bucket: :incomplete).count
  end

  def show
  end

  def edit
    @roles = Role.all
    @openings = Opening.all
    @sources = Source.all
  end

  def update
    @candidate.update(candidate_params.except(:note))
    redirect_to candidate_timeline_path(@candidate), notice: "Candidate was updated successfully"
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
    @candidate = Candidate.new(candidate_params.except(:note))
    @candidate.user = current_user
    if @candidate.save
      note = Note.new(notable: @candidate, user: current_user, body: candidate_params[:note])
      if note.save
        Event.new(eventable: @candidate, action: "add_note", action_for_context: "added a new note", trackable: note, user: current_user).save
      end
      Event.new(eventable: @candidate, action: "add_candidate", action_for_context: "added new candidate", trackable: @candidate, user: current_user).save

      redirect_to candidate_timeline_path(@candidate), notice: "New candidate was created successfully"
    else
      @candidate.errors.full_messages.each do |message|
        puts message
      end
      redirect_to new_candidate_path, alert: "Failed to add candidate. Please try again."
    end
  end

  def recent
    @candidates = Candidate.where(bucket: :recent)
  end

  def hot
    @candidates = Candidate.where(bucket: :hot)
  end

  def pipeline
    @candidates = Candidate.where(bucket: :pipeline)
  end

  def champions
    @candidates = Candidate.where(bucket: :champions)
  end

  def joinings
    @candidates = Candidate.where(bucket: :joinings)
  end

  def icebox
    @candidates = Candidate.where(bucket: :icebox)
  end

  def archive
    @candidates = Candidate.where(bucket: :archive)
  end

  def incomplete
    @candidates = Candidate.where(bucket: :incomplete)
  end

  private

  def candidate_params
    params.require(:candidate).permit(:first_name, :last_name, :email, :phone, :location, :biography, :facebook, :role_id, :source_id, :opening_id, :linkedin, :github, :twitter, :portfolio, :website, :current_ctc, :expected_ctc, :current_company, :current_title, :notice_period, :experience, :birth_year, :highest_qualification, :bucket, :resume, :note)
  end

  def set_candidate
    @candidate ||= Candidate.find(params[:id])
  end
end
