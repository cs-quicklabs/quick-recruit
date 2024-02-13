class CreateCandidates < ActiveRecord::Migration[7.1]
  def change
    create_table :candidates do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, index: { unique: true, name: "unique_emails" }
      t.string :phone, null: false
      t.string :location
      t.text :biography
      t.string :linkedin
      t.string :facebook
      t.string :twitter
      t.string :github
      t.string :website
      t.string :portfolio
      t.string :current_company
      t.string :current_title
      t.string :current_ctc
      t.string :expected_ctc
      t.string :notice_period
      t.integer :experience
      t.integer :birth_year
      t.string :highest_qualification
      t.integer :bucket, default: 0, null: false

      t.timestamps
    end
  end
end
