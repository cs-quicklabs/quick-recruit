class FinishRecycle < Patterns::Service
  def call
    Recycle.where(recycled: true).each do |recycle|
      candidate = recycle.candidate
      candidate.update(bucket_updated_on: DateTime.now)
      Event.new(eventable: candidate, action: "finish_recycle", action_for_context: candidate.bucket, trackable: candidate, user: User.bot).save
      recycle.destroy
    end
  end
end
