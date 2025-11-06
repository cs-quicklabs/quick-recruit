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

  def about_us_and_jd_email
    @candidate = params[:candidate]
    @owner = params[:candidate].owner
    mail(to: [@candidate.email, @owner.email], subject: "Hiring@Crownstack: About Crownstack & Job Description", reply_to: @owner.email)
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
    @candidate = params[:candidate]
    mail(to: [@candidate.owner.email, User.aashish.email], subject: "Hiring@Crownstack: New Lead from Website")
  end

  def f2f_detail_email
    @candidate = params[:candidate]
    @owner = @candidate.owner
    mail(to: [@candidate.email, @owner.email], bcc:  [User.aashish.email], subject: "Hiring@Crownstack: Face-to-Face Interview Details", reply_to: @owner.email)
  end

  def position_closed_email
    @candidate = params[:candidate]
    @owner = @candidate.owner
    mail(to: [@candidate.email, @owner.email], subject: "Hiring@Crownstack: Information on Application", reply_to: @owner.email)
  end

  def send_resume_email
    @candidate = params[:candidate]
    @owner = @candidate.owner
    mail(to: [@candidate.email, @owner.email], subject: "Hiring@Crownstack: Resume Required", reply_to: @owner.email)
  end
end
