class AddBookingPageToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :booking_url, :string
  end
end
