class AddFeedback < ActiveRecord::Migration[8.0]
  def change
    create_table :feedbacks do |t|
      t.string :title, null: false
      t.references :user, foreign_key: true, index: true, null: false
      t.integer :status, default: 0, null: false
      t.integer :nature, default: 0, null: false
      t.references :submitter, null: false, foreign_key: { to_table: :users }, default: 1

      t.timestamps
    end
  end
end
