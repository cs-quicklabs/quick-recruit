class UpdateOwner < Patterns::Service
  def initialize(candidate, owner, actor)
    @candidate = candidate
    @owner = owner
    @actor = actor
  end

  def call
    update_owner
    add_event
    notify_owner if candidate.owner != actor

    candidate
  end

  private

  def update_owner
    candidate.update(owner_id: owner)
  end

  def add_event
    Event.new(eventable: candidate, action: "update_owner", action_for_context: candidate.owner.name, trackable: candidate, user: actor).save
  end

  def notify_owner
    RecruiterMailer.with(candidate: candidate).candidate_assigned_email.deliver_later
  end

  attr_reader :candidate, :owner, :actor
end
