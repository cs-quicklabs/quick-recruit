class AddColumnsToOpening < ActiveRecord::Migration[7.1]
  def change
    add_column :openings, :location, :string
    add_column :openings, :opening_type, :integer, default: 0
    add_column :openings, :active, :boolean, default: true
  end
end
