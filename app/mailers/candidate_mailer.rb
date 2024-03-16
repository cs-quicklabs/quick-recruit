class CandidateMailer < ApplicationMailer
  def rejection_email
    @candidate = params[:candidate]
    mail(to: @candidate.email, subject: "Interview Rejection")
  end
end
