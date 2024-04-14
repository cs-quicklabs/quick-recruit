class AddRoleToOpening < ActiveRecord::Migration[7.1]
  def change
    add_reference :openings, :role, foreign_key: true, default: 15, null: false
  end
end
