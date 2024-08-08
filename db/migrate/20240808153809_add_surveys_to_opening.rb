class AddSurveysToOpening < ActiveRecord::Migration[7.1]
  def change
    add_column :openings, :resume_screening_checklist, :string
    add_column :openings, :telephonic_screening_checklist, :string
    add_column :openings, :first_round_score, :string
    add_column :openings, :second_round_score, :string
    add_column :openings, :hr_round_score, :string
  end
end
