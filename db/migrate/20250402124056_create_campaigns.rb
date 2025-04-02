class CreateCampaigns < ActiveRecord::Migration[8.0]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.references :owner, foreign_key: { to_table: :users }, null: false
      t.date :start_date
      t.date :end_date
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
