class RecyclesController < BaseController
  def index
    @recycles = Recycle.includes(candidate: [:user, :role, :opening, :owner])
    if params[:recruiter].present?
      @recycles = @recycles.select { |recycle| recycle.candidate.owner.id == params[:recruiter].to_i }
    end
    @recruiters = User.recruiters
  end
end
