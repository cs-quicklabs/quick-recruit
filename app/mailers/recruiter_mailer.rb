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
end
