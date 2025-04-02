class Candidate::CampaignsController < Candidate::BaseController
  def index
    @campaigns = @candidate.campaigns
    @campaign = @campaigns.first
  end
end
