class UpdateJoining < Patterns::Service
  def initialize(candidate, joining_date, actor)
    @candidate = candidate
    @joining_date = joining_date
    @actor = actor
  end

  def call
    update_joining_date
    add_event

    candidate
  end

  private

  def update_joining_date
    candidate.update(joining_date: joining_date)
  end

  def add_event
    Event.new(eventable: candidate, action: "update_joining", action_for_context: "update_joining", trackable: candidate, user: actor).save
  end

  attr_reader :candidate, :joining_date, :actor
end
