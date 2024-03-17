class CreateEmails < ActiveRecord::Migration[7.1]
  def change
    create_table :emails do |t|
      t.references :candidate, foreign_key: true, index: true, null: false
      t.references :user, foreign_key: true, index: true, null: false
      t.integer :status, default: 0, null: false
      t.integer :kind, default: 0, null: false

      t.timestamps
    end
  end
end
