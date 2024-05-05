class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.string :title, null: false
      t.references :user, foreign_key: true, index: true, null: false
      t.integer :status, default: 0, null: false
      t.integer :nature, default: 0, null: false

      t.timestamps
    end
  end
end
