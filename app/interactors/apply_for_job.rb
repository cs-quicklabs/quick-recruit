class ApplyForJob < Patterns::Service
  def initialize(params)
    @params = params
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
    @phone = params[:phone]
    @biography = params[:biography]
    @opening_id = params[:opening_id]
  end

  def call
    candidate = existing_candidate || create_candidate
    update_bucket(candidate) if candidate.persisted?

    send_email

    candidate
  end

  private

  def create_candidate
    #Opening becomes "to Be Decided" if form is submitted without selecting an opening
    opening = opening_id.blank? ? Opening.find(20) : Opening.find(opening_id)
    Candidate.create!(first_name: first_name, last_name: last_name, email: email, phone: phone, biography: biography, opening_id: opening.id, role: opening.role, bucket: Candidate.buckets[:leads], user: User.bot, owner: opening.owner, status: Candidate.statuses[:waiting_for_evaluation], source: Source.find_by_title("Website"))
  end

  def existing_candidate
    Candidate.find_by_email(email) or Candidate.find_by_phone(phone)
  end

  def update_bucket(candidate)
    UpdateBucket.call(candidate, Candidate.buckets[:leads], User.bot).result
  end

  def send_email
    CandidateMailer.with(content: params).lead_email.deliver_later
  end

  attr_reader :first_name, :last_name, :email, :phone, :biography, :opening_id, :params
end
