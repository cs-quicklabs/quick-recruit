class RecycleCandidatesJob < ApplicationJob
  def perform
    FinishRecycle.call
    RecycleCandidates.call
  end
end
