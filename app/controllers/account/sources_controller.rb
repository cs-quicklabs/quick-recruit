class Account::SourcesController < Account::BaseController
  before_action :set_source, only: %i[edit update destroy]

  def index
    @sources = Source.all
    @source = Source.new
  end

  def edit
  end

  def create
    @source = Source.new(source_params)

    respond_to do |format|
      if @source.save
        format.turbo_stream {
          render turbo_stream: turbo_stream.prepend(:sources, partial: "account/sources/source", locals: { source: @source }) +
                               turbo_stream.replace(Source.new, partial: "account/sources/form", locals: { source: Source.new, message: "Source was created successfully." })
        }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(Source.new, partial: "account/sources/form", locals: { source: @source })
        }
      end
    end
  end

  def update
    respond_to do |format|
      if @source.update(source_params)
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(@source, partial: "account/sources/source", locals: { source: @source, messages: nil })
        }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(@source, template: "account/sources/edit", locals: { source: @source, messages: @source.errors.full_messages })
        }
      end
    end
  end

  def destroy
    @source.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@source) }
    end
  end

  private

  def set_source
    @source ||= Source.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def source_params
    params.require(:source).permit(:title)
  end
end
