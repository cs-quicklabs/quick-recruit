class CandidateMailer < ApplicationMailer
  def rejection_email
    @candidate = params[:candidate]
    mail(to: [@candidate.email, @candidate.owner.email], subject: "Hiring@Crownstack: Interview Result", reply_to: @candidate.owner.email)
  end

  def about_us_email
    @candidate = params[:candidate]
    mail(to: [@candidate.email, @candidate.owner.email], subject: "Hiring@Crownstack: Company Profile", reply_to: @candidate.owner.email)
  end

  def job_description_email
    @candidate = params[:candidate]
    mail(to: [@candidate.email, @candidate.owner.email], subject: "Hiring@Crownstack: Job Description", reply_to: @candidate.owner.email)
  end
end
