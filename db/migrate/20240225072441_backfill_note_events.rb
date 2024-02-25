class BackfillNoteEvents < ActiveRecord::Migration[7.1]
  def change
    notes = Note.all
    notes.each do |note|
      event = Event.where(trackable: note).first
      if event.nil?
        Event.new(eventable: note.notable, action: "add_note", action_for_context: "added a new note", trackable: note, user: User.first).save
      end
    end
  end
end
