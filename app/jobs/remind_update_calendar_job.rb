class RemindUpdateCalendarJob < ApplicationJob
  queue_as :default

  def perform
    User.where(role: :interviewer).find_each do |user|
      # Replace with your notification logic (email, Slack, etc.)
      RecruiterMailer.remind_update_calendar(user).deliver_later
    end
  end
end
