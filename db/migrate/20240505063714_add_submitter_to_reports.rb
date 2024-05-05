class AddSubmitterToReports < ActiveRecord::Migration[7.1]
  def change
    add_reference :reports, :submitter, null: false, foreign_key: { to_table: :users }, default: 1
  end
end
