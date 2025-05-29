class DashboardController < BaseController
  def events
    @events = Event.includes(:eventable, :trackable, :user).where(action: notificable_actions).order(created_at: :desc).limit(50)
  end

  def recycles
    if current_user.admin?
      @recycles = Candidate.unscoped.where("next_recycle_on > ?", DateTime.now).where(bucket: :icebox).includes(:owner, :opening).order(next_recycle_on: :asc).limit(50)
    else
      @recycles = Candidate.unscoped.where("next_recycle_on > ?", DateTime.now).where(owner_id: current_user.id, bucket: :icebox).includes(:owner, :opening).order(next_recycle_on: :asc).limit(50)
    end
  end

  private

  def notificable_actions
    # show only selected actions in the dashboard
    ["update_bucket", "add_note", "add_report", "add_candidate"]
  end
end
