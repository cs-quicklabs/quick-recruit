class UpdateBucket < Patterns::Service
  def initialize(candidate, bucket, actor)
    @candidate = candidate
    @bucket = bucket
    @actor = actor
  end

  def call
    update_bucket
    add_event

    candidate
  end

  private

  def update_bucket
    candidate.update(bucket: bucket, bucket_updated_on: DateTime.now)
  end

  def add_event
    Event.new(eventable: candidate, action: "update_bucket", action_for_context: candidate.bucket.humanize, trackable: candidate, user: actor).save
  end

  attr_reader :candidate, :bucket, :actor
end
