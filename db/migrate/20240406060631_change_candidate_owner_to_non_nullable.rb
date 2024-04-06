class ChangeCandidateOwnerToNonNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :candidates, :owner_id, false
  end
end
