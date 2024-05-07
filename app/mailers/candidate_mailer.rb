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

  def not_a_match_email
    @candidate = params[:candidate]
    @owner = params[:candidate].owner
    mail(to: [@candidate.email, @owner.email], subject: "Hiring@Crownstack: Update on your application", reply_to: @owner.email)
  end

  def lead_email
    @content = params[:content]
    mail(to: ["shweta@crownstack.com", "aditi@crownstack.com", "aashishdhawan@crownstack.com"], subject: "Hiring@Crownstack: New Lead from Website")
  end
end
