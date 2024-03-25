class ImportUser
  require "csv"

  def call(file)
    opened_file = File.open(file)
    options = { headers: true, col_sep: "," }
    CSV.foreach(opened_file, **options) do |row|
      user = User.find_by_email(row["Email"])
      unless user.nil?
        user.zoho_id = row["User ID"]
        user.save
      end
    end
  end
end
