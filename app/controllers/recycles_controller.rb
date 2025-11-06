class RecyclesController < BaseController
  def index
    @recycles = get_recycles
    @recruiters = User.recruiters
    @recruiters = @recruiters +  [current_user] unless @recruiters.include?(current_user)

  end

  def settle
    FinishRecycle.call
    RecycleCandidates.call
    redirect_to recycle_path, notice: "Recycles settled successfully"
  end

  private

  def recycles_for_admin
    recycles = Recycle.includes(candidate: [:user, :role, :opening, :owner])
    if params[:recruiter].present?
      recycles = recycles.select { |recycle| recycle.candidate.owner.id == params[:recruiter].to_i }
    end

    recycles
  end

  def recycles_for_recruiter
    Recycle.includes(candidate: [:user, :role, :opening, :owner]).where(candidate: { owner: current_user })
  end

  def get_recycles
    (current_user.admin? or current_user.super_admin?) ? recycles_for_admin : recycles_for_recruiter
  end
end
