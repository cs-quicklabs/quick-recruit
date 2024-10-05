class Candidate::EmailsController < Candidate::BaseController
  def index
    @emails = Email.where(candidate: @candidate).includes(:user).order(created_at: :desc)
  end

  def create
    email = SendEmail.call(@candidate, params[:kind], current_user).result
    respond_to do |format|
      if email.persisted?
        format.turbo_stream { render turbo_stream: turbo_stream.prepend(:emails, partial: "candidate/emails/email", locals: { email: email }) }
      end
    end
  end
end
