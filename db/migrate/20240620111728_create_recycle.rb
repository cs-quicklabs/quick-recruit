class CreateRecycle < ActiveRecord::Migration[7.1]
  def change
    create_table :recycles do |t|
      t.references :candidate, null: false, foreign_key: true
      t.boolean :recycled, default: false
      t.timestamps
    end
  end
end
