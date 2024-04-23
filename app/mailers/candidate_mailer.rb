class CandidateMailer < ApplicationMailer
  def rejection_email
    candidate = params[:candidate].email
    owner = candidate.owner.email
    mail(to: [@candidate, owner], from: owner, subject: "Hiring@Crownstack: Interview Result", reply_to: candidate)
  end

  def about_us_email
    candidate = params[:candidate].email
    owner = candidate.owner.email
    mail(to: [candidate, owner], from: owner, subject: "Hiring@Crownstack: Company Profile", reply_to: candidate)
  end

  def job_description_email
    candidate = params[:candidate].email
    owner = candidate.owner.email
    mail(to: [candiate, owner], from: owner, subject: "Hiring@Crownstack: Job Description", reply_to: candidate)
  end
end
