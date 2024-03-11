class AddColumnToCandidate < ActiveRecord::Migration[7.1]
  def change
    add_column :candidates, :bucket_updated_on, :datetime, default: Time.zone.now
  end
end
