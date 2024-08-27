class RewardCandidateToRecruiter < Patterns::Service
  def initialize(candidate, recruiter, actor)
    @candidate = candidate
    @recruiter = recruiter
    @actor = actor
  end

  def call
    reward_candidate
    add_event

    candidate
  end

  private

  def reward_candidate
    candidate.update(owner: recruiter, user: recruiter, created_at: Time.zone.now, updated_at: Time.zone.now)
  end

  def add_event
    Event.new(eventable: candidate, action: "rewarded", action_for_context: "rewarded candidate", trackable: recruiter, user: actor).save
  end

  attr_reader :candidate, :actor, :recruiter
end
