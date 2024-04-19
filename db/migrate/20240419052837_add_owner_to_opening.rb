class AddOwnerToOpening < ActiveRecord::Migration[7.1]
  def change
    add_reference :openings, :owner, null: false, foreign_key: { to_table: :users }, default: 1
  end
end
