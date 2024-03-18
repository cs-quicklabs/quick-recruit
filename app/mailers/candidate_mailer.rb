class CandidateMailer < ApplicationMailer
  def rejection_email
    @candidate = params[:candidate]
    mail(to: @candidate.email, subject: "Hiring@Crownstack: Interview Result")
  end

  def about_us_email
    @candidate = params[:candidate]
    mail(to: @candidate.email, subject: "Hiring@Crownstack: Company Profile")
  end
end
