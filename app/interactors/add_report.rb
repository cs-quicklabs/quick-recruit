class AddReport < Patterns::Service
  def initialize(user, submitter, params, status)
    @user = user
    @submitter = submitter
    @params = params
    @report = Report.new params
    @status = status
  end

  def call
    add_report
    add_event

    report
  end

  private

  def add_report
    report.user_id = user.id
    report.submitter_id = submitter.id
    report.status = status
    report.save!
  end

  def add_event
    Event.new(eventable: user, action: "add_report", action_for_context: "added a new report", trackable: report, user: submitter).save
  end

  attr_reader :user, :submitter, :params, :report, :status
end
