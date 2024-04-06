class UpdateOwner < Patterns::Service
  def initialize(candidate, owner, actor)
    @candidate = candidate
    @owner = owner
    @actor = actor
  end

  def call
    update_owner
    add_event

    candidate
  end

  private

  def update_owner
    candidate.update(owner_id: owner)
  end

  def add_event
    Event.new(eventable: candidate, action: "update_owner", action_for_context: candidate.owner.name, trackable: candidate, user: actor).save
  end

  attr_reader :candidate, :owner, :actor
end
