class ChangeTypeOfExperienceColumnInCandidate < ActiveRecord::Migration[7.1]
  def change
    change_column :candidates, :experience, :decimal, precision: 4, scale: 2
  end
end
