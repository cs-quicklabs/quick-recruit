class MidnightJob < ApplicationJob
  def perform
    FinishRecycle.call
    RecycleCandidates.call
    DailyActivityReport.call
  end
end
