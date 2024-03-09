class AddColumnToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :location, :string
    add_column :users, :phone, :string
    add_column :users, :biography, :text
    add_column :users, :linkedin, :string
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
    add_column :users, :github, :string
    add_column :users, :website, :string
    add_column :users, :portfolio, :string
    add_column :users, :current_company, :string
    add_column :users, :current_title, :string
    add_column :users, :experience, :integer
    add_column :users, :birth_year, :integer
    add_column :users, :active, :boolean, default: true
    add_column :users, :inactive_at, :datetime
  end
end
