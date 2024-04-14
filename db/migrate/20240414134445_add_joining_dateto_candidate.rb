class AddJoiningDatetoCandidate < ActiveRecord::Migration[7.1]
  def change
    add_column :candidates, :joining_date, :date
  end
end
