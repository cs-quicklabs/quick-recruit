class AddPriorityToOpening < ActiveRecord::Migration[7.1]
  def change
    add_column :openings, :priority, :integer, default: 0
  end
end
