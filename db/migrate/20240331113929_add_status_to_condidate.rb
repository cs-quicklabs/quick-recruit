class AddStatusToCondidate < ActiveRecord::Migration[7.1]
  def change
    add_column :candidates, :status, :integer, default: 0
    add_column :candidates, :status_updated_on, :datetime, default: DateTime.now, null: false
    change_column :candidates, :bucket_updated_on, :datetime, default: DateTime.now, null: false
  end
end
