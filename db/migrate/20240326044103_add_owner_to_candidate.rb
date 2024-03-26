class AddOwnerToCandidate < ActiveRecord::Migration[7.1]
  def change
    add_reference :candidates, :owner, foreign_key: { to_table: :users }, null: true
  end
end
