class CreateOpeningsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :openings_users do |t|
      t.references :opening, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :openings_users, [:opening_id, :user_id], unique: true
  end
end
