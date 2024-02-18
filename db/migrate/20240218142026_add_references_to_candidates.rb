class AddReferencesToCandidates < ActiveRecord::Migration[7.1]
  def change
    add_reference :candidates, :role, foreign_key: true
    add_reference :candidates, :source, foreign_key: true
    add_reference :candidates, :opening, foreign_key: true
  end
end
