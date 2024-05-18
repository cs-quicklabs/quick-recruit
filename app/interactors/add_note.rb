class AddNote < Patterns::Service
  def initialize(candidate, params, actor)
    @candidate = candidate
    @note = @candidate.notes.new params
    @actor = actor
  end

  def call
    add_note
    add_event
    notify_owner if candidate.owner != actor

    note
  end

  private

  def add_note
    note.user_id = actor.id
    note.save!
    candidate.touch
  end

  def add_event
    Event.new(eventable: candidate, action: "add_note", action_for_context: "added a new note", trackable: note, user: actor).save
  end

  def notify_owner
    RecruiterMailer.with(candidate: candidate).new_note_email.deliver_later
  end

  attr_reader :candidate, :note, :actor
end
