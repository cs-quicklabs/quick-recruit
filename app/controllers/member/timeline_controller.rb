class Member::TimelineController < Member::BaseController
  def index
    def index
      @events = Event.includes(:eventable, :trackable, :user => { avatar_attachment: :blob }).where(user: @member).order(created_at: :desc).limit(50)
    end
  end
end
