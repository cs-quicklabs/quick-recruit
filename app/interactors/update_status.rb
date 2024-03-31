class UpdateStatus < Patterns::Service
  def initialize(candidate, status, actor)
    @candidate = candidate
    @status = status
    @actor = actor
  end

  def call
    update_status
    add_event

    candidate
  end

  private

  def update_status
    candidate.update(status: status, status_updated_on: DateTime.now)
  end

  def add_event
    Event.new(eventable: candidate, action: "update_status", action_for_context: candidate.status.humanize, trackable: candidate, user: actor).save
  end

  attr_reader :candidate, :status, :actor
end
