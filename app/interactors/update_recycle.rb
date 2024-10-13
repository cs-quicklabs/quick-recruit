class UpdateRecycle < Patterns::Service
  def initialize(candidate, recycle_date, actor)
    @candidate = candidate
    @next_recycle_on = recycle_date
    @actor = actor
  end

  def call
    update_recycle_date
    add_event

    candidate
  end

  private

  def update_recycle_date
    candidate.update(next_recycle_on: next_recycle_on)
  end

  def add_event
    Event.new(eventable: candidate, action: "update_recycle", action_for_context: "update_recycle", trackable: candidate, user: actor).save
  end

  attr_reader :candidate, :next_recycle_on, :actor
end
