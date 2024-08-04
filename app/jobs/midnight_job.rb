class MidnightJob < ApplicationJob
  def perform
    FinishRecycle.call
    RecycleCandidates.call
    DailyActivityReport.Call
  end
end
