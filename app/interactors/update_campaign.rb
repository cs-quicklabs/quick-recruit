class UpdateCampaign < Patterns::Service
  def initialize(candidate, campaign_id, actor)
    @candidate = candidate
    @campaign = Campaign.find_by(id: campaign_id)
    @actor = actor
  end

  def call
    update_campaign
    add_event

    candidate
  end

  private

  def update_campaign
    candidate.campaigns.destroy_all
    candidate.campaigns << campaign unless candidate.campaigns.include?(campaign)
  end

  def add_event
    Event.new(eventable: candidate, action: "update_campaign", action_for_context: "update_campaign", trackable: campaign, user: actor).save
  end

  attr_reader :candidate, :campaign, :actor
end
