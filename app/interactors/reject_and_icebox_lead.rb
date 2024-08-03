class RejectAndIceboxLead < Patterns::Service
  def initialize(candidate, actor)
    @candidate = candidate
    @actor = actor
  end

  def call
    SendEmail.call(candidate, "not_a_match_email", actor)
    UpdateStatus.call(candidate, :rejected_in_screening, actor)
    UpdateBucket.call(candidate, :icebox, actor)

    candidate
  end

  private

  attr_reader :candidate, :actor
end
