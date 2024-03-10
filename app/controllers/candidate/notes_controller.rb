class Candidate::NotesController < Candidate::BaseController
  before_action :set_note, only: %i[destroy edit update]

  def index
    @note = Note.new
    @pagy, @notes = pagy_nil_safe(params, @candidate.notes.includes(:user).order(created_at: :desc), items: LIMIT)
    render_partial("candidate/notes/note", collection: @notes) if stale?(@notes + [@candidate])
  end

  def destroy
    @note.destroy
    Event.where(eventable: @candidate, trackable: @note).touch_all #fixes cache issues in activity
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@note) }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@note, partial: "candidate/notes/note", locals: { note: @note }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@note, template: "candidate/notes/edit", locals: { note: @note }) }
      end
    end
  end

  def create
    @note = AddNote.call(@candidate, note_params, current_user).result
    respond_to do |format|
      if @note.persisted?
        format.turbo_stream {
          render turbo_stream: turbo_stream.prepend(:notes, partial: "candidate/notes/note", locals: { note: @note }) +
                               turbo_stream.replace(Note.new, partial: "candidate/notes/form", locals: { note: Note.new })
        }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(Note.new, partial: "candidate/notes/form", locals: { note: @note }) }
      end
    end
  end

  private

  def set_note
    @note ||= Note.find(params["id"])
  end

  def note_params
    params.require(:note).permit(:body)
  end
end
