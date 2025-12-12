class Public::TeamController < Public::PublicController
  def index
    @members = User.where(active: true, role: [:interviewer, :recruiter, :admin, :recruiter_admin, :super_admin]).order(:name)
  end
end
