class AddNote < Patterns::Service
  def initialize(candidate, params, actor)
    @candidate = candidate
    @note = @candidate.notes.new params
    @actor = actor
  end

  def call
    add_note
    add_event

    note
  end

  private

  def add_note
    note.user_id = actor.id
    note.save!
  end

  def add_event
    Event.new(eventable: candidate, action: "add_note", action_for_context: "added a new note", trackable: note, user: actor).save
  end

  attr_reader :candidate, :note, :actor
end
