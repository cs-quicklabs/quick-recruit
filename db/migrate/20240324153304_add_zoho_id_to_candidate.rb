class AddZohoIdToCandidate < ActiveRecord::Migration[7.1]
  def change
    add_column :candidates, :zoho_id, :string, null: true
  end
end
