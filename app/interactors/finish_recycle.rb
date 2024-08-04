class FinishRecycle < Patterns::Service
  def call
    #notify_about_recycled_candidates
    remove_recycled_candidates
  end

  def notify_about_recycled_candidates
    User.recruiters.each do |recruiter|
      count = Recycle.includes(candidate: [:owner]).where(recycled: true, candidate: { owner_id: recruiter.id }).count
      RecruiterMailer.with(recruiter: recruiter, count: count).recycled_candidates_email.deliver_later
    end
  end

  def remove_recycled_candidates
    Recycle.where(recycled: true).each do |recycle|
      update_candidate(recycle.candidate)
      recycle.destroy
    end
  end

  def update_candidate(candidate)
    candidate.update(bucket_updated_on: DateTime.now)
    Event.new(eventable: candidate, action: "finish_recycle", action_for_context: candidate.bucket, trackable: candidate, user: User.bot).save
  end
end
