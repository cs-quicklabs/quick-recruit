class AddZohoIdToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :zoho_id, :string, null: true
  end
end
