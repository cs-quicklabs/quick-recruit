class CreateSource < ActiveRecord::Migration[7.1]
  def change
    create_table :sources do |t|
      t.string :title

      t.timestamps
    end
  end
end
