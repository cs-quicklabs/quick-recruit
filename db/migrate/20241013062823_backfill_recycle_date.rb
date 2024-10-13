class BackfillRecycleDate < ActiveRecord::Migration[8.0]
  def change
    Candidate.where(next_recycle_on: nil).each do |candidate|
      candidate.update(next_recycle_on: 6.months.from_now)
    end
  end
end
