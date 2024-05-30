class DashboardController < BaseController
  def events
    @events = Event.includes(:eventable, :trackable, :user).where(action: notificable_actions).order(created_at: :desc).limit(50)
  end

  private

  def notificable_actions
    # show only selected actions in the dashboard
    ["update_bucket", "add_note", "add_report", "add_candidate"]
  end
end
