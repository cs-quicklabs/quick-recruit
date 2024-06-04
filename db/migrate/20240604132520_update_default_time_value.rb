class UpdateDefaultTimeValue < ActiveRecord::Migration[7.1]
  def change
    change_column :candidates, :status_updated_on, :datetime, default: -> { "CURRENT_TIMESTAMP" }, null: false
    change_column :candidates, :bucket_updated_on, :datetime, default: -> { "CURRENT_TIMESTAMP" }, null: false
  end
end
