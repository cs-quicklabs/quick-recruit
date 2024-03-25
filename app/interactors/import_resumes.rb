class ImportResumes
  require "csv"

  def call(file)
    opened_file = File.open(file)
    options = { headers: true, col_sep: "," }
    CSV.foreach(opened_file, **options) do |row|
      if row["Attachment Category Id"] == "Zrecruit_591004000000072325"
        puts row.to_hash
        candidate = Candidate.find_by(zoho_id: row["Parent ID"])
        unless candidate.nil?
          unless row["File Name"].nil?
            Note.create(body: row["File Name"], user_id: 4, notable: candidate)
          end
        end
      end
    end
  end
end
