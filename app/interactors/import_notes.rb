class ImportNotes
  require "csv"

  def call(file)
    opened_file = File.open(file)
    options = { headers: true, col_sep: "," }
    CSV.foreach(opened_file, **options) do |row|
      puts row.to_hash
      candidate = Candidate.find_by(zoho_id: row["Candidate Id"])
      unless candidate.nil?
        unless row["Note Content"].nil?
          Note.create(body: row["Note Content"], user_id: 4, notable: candidate)
        end
      end
    end
  end
end
