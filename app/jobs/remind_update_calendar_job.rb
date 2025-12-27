class RemindUpdateCalendarJob < ApplicationJob
  def perform
    User.where(role: [:interviewer, :admin, :recruiter_admin, :super_admin]).find_each do |user|
      # Replace with your notification logic (email, Slack, etc.)
      RecruiterMailer.remind_to_update_calendar(user).deliver_later
    end
  end
end
