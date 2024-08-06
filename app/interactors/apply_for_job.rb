class ApplyForJob < Patterns::Service
  def initialize(params)
    @params = params
  end

  def call
    candidate = existing_candidate || create_candidate

    if should_create_new_lead_for?(candidate)
      move_to_leads(candidate)
      assign_to_recruiter(candidate)
      send_email(candidate)
    end

    candidate
  end

  private

  def should_create_new_lead_for?(candidate)
    candidate.persisted? && !candidate.archive? && candidate.bucket != Candidate.buckets[:leads]
  end

  def create_candidate
    #Opening becomes "to Be Decided" if form is submitted without selecting an opening
    opening = params[:opening_id].blank? ? Opening.find(20) : Opening.find(params[:opening_id])

    candidate = Candidate.new(params.except(:note))
    candidate.role = opening.role
    candidate.opening_id = opening.id
    candidate.bucket = Candidate.buckets[:leads]
    candidate.user = User.bot
    candidate.owner = opening.owner
    candidate.status = Candidate.statuses[:waiting_for_evaluation]
    candidate.source = Source.find_by_title("Website")

    candidate.save

    candidate
  end

  def existing_candidate
    candidate = Candidate.find_by_email(params[:email]) or Candidate.find_by_phone(params[:phone])
    params[:opening_id] = 20.to_s if params[:opening_id].blank?

    # update old info to newest one
    candidate.update!(params) unless candidate.nil?

    candidate
  end

  def move_to_leads(candidate)
    UpdateBucket.call(candidate, Candidate.buckets[:leads], User.bot, false).result
  end

  def send_email(candidate)
    CandidateMailer.with(candidate: candidate, content: params.except(:resume)).lead_email.deliver_later
  end

  def assign_to_recruiter(candidate)
    # by default all leads from website are assigned to Rakhi
    UpdateOwner.call(candidate, User.rakhi, User.bot, false).result
  end

  attr_reader :params
end
