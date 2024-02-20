class AddCreatorToCandidate < ActiveRecord::Migration[7.1]
  def change
    add_reference :candidates, :user, foreign_key: true, default: 1, null: false
  end
end
