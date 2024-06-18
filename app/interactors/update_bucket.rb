class UpdateBucket < Patterns::Service
  def initialize(candidate, bucket, actor, notify = true)
    @candidate = candidate
    @bucket = bucket
    @actor = actor
    @notify = notify
  end

  def call
    update_bucket
    add_event
    notify_owner if candidate.owner != actor

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
    RecruiterMailer.with(candidate: candidate).candidate_moved_email.deliver_later if notify
  end

  attr_reader :candidate, :bucket, :actor, :notify
end
