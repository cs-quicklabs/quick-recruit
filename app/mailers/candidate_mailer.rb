class CandidateMailer < ApplicationMailer
  def rejection_email
    @candidate = params[:candidate]
    mail(to: @candidate.email, subject: "Hiring@Crownstack: Interview Result")
  end
end
