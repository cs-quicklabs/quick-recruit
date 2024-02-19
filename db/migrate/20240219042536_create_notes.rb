class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.text :body
      t.references :notable, polymorphic: true, index: true
      t.references :user, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
