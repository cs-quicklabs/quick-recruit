class Member::TimelineController < Member::BaseController
  def index
    def index
      @events = Event.where(user: @member).order(created_at: :desc).limit(50)

      fresh_when @events
    end
  end
end
