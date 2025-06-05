class UpdateBucket < Patterns::Service
  def initialize(candidate, bucket, actor, notify = true)
    @candidate = candidate
    @bucket = bucket
    @actor = actor
    @notify = notify
  end

  def call
    update_bucket
    update_next_recycle_date
    add_event
    notify_owner

    candidate
  end

  private

  def update_bucket
    candidate.update(bucket: bucket, bucket_updated_on: DateTime.now)
  end

  def add_event
    Event.new(eventable: candidate, action: "update_bucket", action_for_context: candidate.bucket.humanize, trackable: candidate, user: actor).save
  end

  def notify_owner
    RecruiterMailer.with(candidate: candidate).candidate_moved_email.deliver_later if notify && candidate.owner != actor
  end

  def update_next_recycle_date
    candidate.update(next_recycle_on: 6.months.from_now) if candidate.bucket == "icebox" or candidate.bucket == "champions" or candidate.bucket == "alumni"
  end

  attr_reader :candidate, :bucket, :actor, :notify
end
