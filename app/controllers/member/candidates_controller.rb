class Member::CandidatesController < Member::BaseController
  def index
    @champions = Candidate.where(bucket: :champions, owner_id: current_user.id)
  end
end
