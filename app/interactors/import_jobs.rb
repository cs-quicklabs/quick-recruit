class ImportJobs
  require "csv"

  def call(file)
    opened_file = File.open(file)
    options = { headers: true, col_sep: "," }
    CSV.foreach(opened_file, **options) do |row|
      puts row.to_hash
      candidates = Candidate.where(zoho_job_id: row["Job Opening Id"])
      unless candidates.nil?
        candidates.each do |candidate|
          unless row["Posting Title"].nil?
            Note.create(body: row["Posting Title"], user_id: 4, notable: candidate)
          end
        end
      end
    end
  end
end
