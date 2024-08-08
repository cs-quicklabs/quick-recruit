class RecruiterMailer < ApplicationMailer
  def candidate_assigned_email
    @candidate = params[:candidate]
    @owner = params[:candidate].owner
    mail(to: @owner.email, subject: "Quick Recruit: New Candidate #{@candidate.name} assigned")
  end

  def candidate_moved_email
    @candidate = params[:candidate]
    @owner = params[:candidate].owner
    mail(to: @owner.email, subject: "Quick Recruit: Bucket updated for #{@candidate.name}")
  end

  def new_note_email
    @candidate = params[:candidate]
    @owner = params[:candidate].owner
    mail(to: @owner.email, subject: "Quick Recruit: New note added for #{@candidate.name}")
  end

  def recycled_candidates_email
    @recruiter = params[:recruiter]
    @count = params[:count]
    mail(to: [@recruiter.email, User.aashish.email, User.aditi.email], subject: "Quick Recruit: Recycling Report")
  end

  def daily_activity_report_email
    @recruiter = params[:recruiter]
    @new_candidates_count = params[:new_candidates_count]
    @updated_candidates_count = params[:updated_candidates_count]
    @pipelined_candidates_count = params[:pipelined_candidates_count]
    @new_candidates_daily_report_url = params[:new_candidates_daily_report_url]
    @updated_candidates_daily_report_url = params[:updated_candidates_daily_report_url]
    @pipelined_candidates_daily_report_url = params[:pipelined_candidates_daily_report_url]
    mail(to: [@recruiter.email, User.aashish.email, User.aditi.email], subject: "Quick Recruit: Daily Activity Report")
  end
end
