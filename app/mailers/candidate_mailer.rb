class CandidateMailer < ApplicationMailer
  def rejection_email
    @candidate = params[:candidate]
    @owner = params[:candidate].owner
    mail(to: [@candidate.email, @owner.email], subject: "Hiring@Crownstack: Interview Result", reply_to: @owner.email)
  end

  def about_us_email
    @candidate = params[:candidate]
    @owner = params[:candidate].owner
    mail(to: [@candidate.email, @owner.email], subject: "Hiring@Crownstack: Company Profile", reply_to: @owner.email)
  end

  def job_description_email
    @candidate = params[:candidate]
    @owner = params[:candidate].owner
    mail(to: [@candidate.email, @owner.email], subject: "Hiring@Crownstack: Job Description", reply_to: @owner.email)
  end
end
