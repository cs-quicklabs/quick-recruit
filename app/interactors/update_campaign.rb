class UpdateCampaign < Patterns::Service
  def initialize(candidate, campaign_id, actor)
    @candidate = candidate
    @campaign = Campaign.find_by(id: campaign_id)

    @actor = actor
  end

  def call
    update_campaign

    candidate
  end

  private

  def update_campaign
    if campaign.nil?
      add_event
      candidate.campaigns.destroy_all
    else
      candidate.campaigns.destroy_all
      candidate.campaigns << campaign unless candidate.campaigns.include?(campaign)
      add_event
    end
  end

  def add_event
    if campaign.nil?
      Event.new(eventable: candidate, action: "remove_campaign", action_for_context: "remove_campaign", trackable: candidate.campaigns.first, user: actor).save
    else
      Event.new(eventable: candidate, action: "update_campaign", action_for_context: "update_campaign", trackable: campaign, user: actor).save
    end
  end

  attr_reader :candidate, :campaign, :actor
end
