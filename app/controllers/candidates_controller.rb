class CandidatesController < BaseController
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
    @candidates_count = Candidate.count
  end

  def show
  end

  def update_bucket
    redirect_to candidates_path, notice: "Bucket was updated successfully"
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
      Event.new(eventable: @candidate, action: "add_candidate", action_for_context: "added new candidate", trackable: @candidate, user: current_user).save

      note = Note.new(notable: @candidate, user: current_user, body: candidate_params[:note])
      if note.save
        Event.new(eventable: @candidate, action: "add_note", action_for_context: "added a new note", trackable: note, user: current_user).save
      end

      redirect_to candidate_timeline_path(@candidate), notice: "New candidate was created successfully"
    else
      @candidate.errors.full_messages.each do |message|
        puts message
      end
      redirect_to new_candidate_path, alert: "Failed to add candidate. Please try again."
    end
  end

  def recent
    @pagy, @candidates = pagy(candidates_for_bucket(:recent), items: LIMIT)

    fresh_when @candidates
  end

  def hot
    @pagy, @candidates = pagy(candidates_for_bucket(:hot), items: LIMIT)

    fresh_when @candidates
  end

  def pipeline
    @pagy, @candidates = pagy(candidates_for_bucket(:pipeline), items: LIMIT)

    fresh_when @candidates
  end

  def champions
    @pagy, @candidates = pagy(candidates_for_bucket(:champions), items: LIMIT)

    fresh_when @candidates
  end

  def joinings
    @pagy, @candidates = pagy(candidates_for_bucket(:joinings), items: LIMIT)

    fresh_when @candidates
  end

  def icebox
    @pagy, @candidates = pagy(candidates_for_bucket(:icebox), items: LIMIT)

    fresh_when @candidates
  end

  def archive
    @pagy, @candidates = pagy(candidates_for_bucket(:archive), items: LIMIT)

    fresh_when @candidates
  end

  def incomplete
    @pagy, @candidates = pagy(candidates_for_bucket(:incomplete), items: LIMIT)

    fresh_when @candidates
  end

  private

  def candidates_for_bucket(bucket)
    Candidate.unscoped.where(bucket: bucket).includes(:opening, :role, :user).order(bucket_updated_on: :desc)
  end

  def candidate_params
    params.require(:candidate).permit(:first_name, :last_name, :email, :phone, :location, :biography, :facebook, :role_id, :source_id, :opening_id, :linkedin, :github, :twitter, :portfolio, :website, :current_ctc, :expected_ctc, :current_company, :current_title, :notice_period, :experience, :birth_year, :highest_qualification, :bucket, :resume, :note)
  end

  def set_candidate
    @candidate ||= Candidate.find(params[:id])
  end
end
