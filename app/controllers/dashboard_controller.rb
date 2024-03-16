class DashboardController < BaseController
  def events
    @events = Event.includes(:eventable, :trackable, :user => { avatar_attachment: :blob }).order(created_at: :desc).limit(50)
  end
end
