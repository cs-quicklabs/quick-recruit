class SendEmail < Patterns::Service
  def initialize(candidate, params, actor)
    @candidate = candidate
    @email = Email.new(kind: 0, user_id: actor.id)
    @actor = actor
  end

  def call
    create_email
    send_email
    add_event

    email
  end

  private

  def create_email
    @email.save
  end

  def send_email
  end

  def add_event
    Event.new(eventable: candidate, action: "send_email", action_for_context: "sent an email with subject", trackable: email, user: actor).save
  end

  attr_reader :candidate, :email, :actor
end
