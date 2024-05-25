class ApplyForJob < Patterns::Service
  def initialize(params)
    @params = params
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
    @phone = params[:phone]
    @biography = params[:biography]
    @opening_id = params[:opening_id]
    @location = params[:location]
    @birth_year = params[:birth_year]
    @current_company = params[:current_company]
    @current_title = params[:current_title]
    @current_ctc = params[:current_ctc]
    @expected_ctc = params[:expected_ctc]
    @notice_period = params[:notice_period]
    @experience = params[:experience]
    @highest_qualification = params[:highest_qualification]
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

    Candidate.create!(first_name: first_name, last_name: last_name, email: email, phone: phone, biography: biography, opening_id: opening.id, role: opening.role, bucket: Candidate.buckets[:leads], user: User.bot, owner: opening.owner, status: Candidate.statuses[:waiting_for_evaluation], source: Source.find_by_title("Website"), location: location, birth_year: birth_year, current_company: current_company, current_title: current_title, current_ctc: current_ctc, expected_ctc: expected_ctc, notice_period: notice_period, experience: experience, highest_qualification: highest_qualification)
  end

  def existing_candidate
    candidate = Candidate.find_by_email(email) or Candidate.find_by_phone(phone)

    # update old info to newest one
    candidate.update(first_name: first_name, last_name: last_name, biography: biography, location: location, birth_year: birth_year, current_company: current_company, current_title: current_title, current_ctc: current_ctc, expected_ctc: expected_ctc, notice_period: notice_period, experience: experience, highest_qualification: highest_qualification) if candidate.persisted?

    candidate
  end

  def update_bucket(candidate)
    UpdateBucket.call(candidate, Candidate.buckets[:leads], User.bot).result
  end

  def send_email
    CandidateMailer.with(content: params).lead_email.deliver_later
  end

  attr_reader :first_name, :last_name, :email, :phone, :biography, :opening_id, :location, :birth_year, :current_title, :current_company, :current_ctc, :expected_ctc, :notice_period, :experience, :highest_qualification, :params
end
