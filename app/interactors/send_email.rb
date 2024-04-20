class SendEmail < Patterns::Service
  def initialize(candidate, kind, actor)
    @candidate = candidate
    @email = Email.new
    @actor = actor
    @kind = kind
  end

  def call
    create_email
    send_email
    add_event

    email
  end

  private

  def create_email
    email.candidate = candidate
    email.user = actor
    email.kind = Email.kinds[kind]
    email.save
    candidate.touch
  end

  def send_email
    case kind
    when "rejection_email"
      CandidateMailer.with(candidate: candidate).rejection_email.deliver_later
    when "about_us_email"
      CandidateMailer.with(candidate: candidate).about_us_email.deliver_later
    when "job_description_email"
      CandidateMailer.with(candidate: candidate).job_description_email.deliver_later
    end
  end

  def add_event
    Event.new(eventable: candidate, action: "send_email", action_for_context: "sent an email with subject", trackable: email, user: actor).save
  end

  attr_reader :candidate, :email, :actor, :kind
end
