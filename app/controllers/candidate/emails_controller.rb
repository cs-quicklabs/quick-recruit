class Candidate::EmailsController < Candidate::BaseController
  def create
    send_email = SendEmail.call(@candidate, params[:email], current_user).result
  end
end
