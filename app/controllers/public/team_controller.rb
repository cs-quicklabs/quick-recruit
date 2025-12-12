class Public::TeamController < Public::PublicController
  def index
    @members = User.where(active: true, role: :interviewer).order(:name)
  end
end
