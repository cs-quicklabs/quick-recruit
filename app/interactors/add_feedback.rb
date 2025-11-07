class AddFeedback < Patterns::Service
  def initialize(user, submitter, params, status)
    @user = user
    @submitter = submitter
    @params = params
    @feedback = Feedback.new params
    @status = status
  end

  def call
    add_feedback
    add_event
    notify_user

    feedback
  end

  private

  def add_feedback
    feedback.user_id = user.id
    feedback.submitter_id = submitter.id
    feedback.status = status
    feedback.save!
  end

  def add_event
    Event.new(eventable: user, action: "add_feedback", action_for_context: "added a new feedback", trackable: feedback, user: submitter).save
  end

  def notify_user
    RecruiterMailer.with(feedback: feedback).feedback_received_email.deliver_later
  end

  attr_reader :user, :submitter, :params, :feedback, :status
end
