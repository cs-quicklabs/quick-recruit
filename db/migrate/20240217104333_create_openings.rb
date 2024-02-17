class CreateOpenings < ActiveRecord::Migration[7.1]
  def change
    create_table :openings do |t|
      t.string :title

      t.timestamps
    end
  end
end
