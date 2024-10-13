class AddNextRecyleDateToCandidate < ActiveRecord::Migration[8.0]
  def change
    add_column :candidates, :next_recycle_on, :datetime
  end
end
