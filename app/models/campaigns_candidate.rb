class CampaignsCandidate < ApplicationRecord
  belongs_to :candidate
  belongs_to :campaign
end
