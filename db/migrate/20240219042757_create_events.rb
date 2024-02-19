class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.integer :user_id, null: false, index: true
      t.string :action
      t.integer :eventable_id
      t.string :eventable_type
      t.string :action_for_context
      t.integer :trackable_id
      t.string :trackable_type

      t.timestamps
    end
  end
end
