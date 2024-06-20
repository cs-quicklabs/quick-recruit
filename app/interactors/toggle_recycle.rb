class ToggleRecycle < Patterns::Service
  def initialize(candidate, actor)
    @candidate = candidate
    @actor = actor
    @recycle = Recycle.find_by(candidate: candidate)
  end

  def call
    toggle
    add_event

    candidate
  end

  private

  def toggle
    recycle.update(recycled: !recycle.recycled) unless recycle.nil?
  end

  def add_event
    action_for_context = recycle.recycled ? "marked candidate for recycling" : "unmarked candidate for recycling"
    Event.new(eventable: candidate, action: "toggle_recycle", action_for_context: action_for_context, trackable: candidate, user: actor).save
  end

  attr_reader :candidate, :actor, :recycle
end
