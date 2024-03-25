class ImportAssociations
  require "csv"

  def call(file)
    opened_file = File.open(file)
    options = { headers: true, col_sep: "," }
    CSV.foreach(opened_file, **options) do |row|
      candidate = Candidate.find_by(zoho_id: row["Candidate ID"])
      unless candidate.nil?
        candidate.update(zoho_job_id: row["Job Opening ID"])
        candidate.save
      end
    end
  end
end
