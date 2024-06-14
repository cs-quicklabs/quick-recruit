class ImportNaukariCandidates
  require "csv"

  def call(file)
    opened_file = File.open(file)
    options = { headers: true, col_sep: "," }
    CSV.foreach(opened_file, **options) do |row|
      candidate = Candidate.find_by_email(row["Email"])
      first_name = row["Candidate Name"].split(" ").first
      last_name = ""

      if row["Candidate Name"].split(" ").length > 2
        last_name = row["Candidate Name"].split(" ").last(2).join(" ")
      else
        last_name = row["Candidate Name"].split(" ").last
      end

      experience = row["Work Exp"]
      experience = experience.gsub("Y ", ".")
      experience = experience.gsub(" M", "")
      experience = experience.to_f

      year_of_birth = nil
      unless row["Age/Date of Birth"].nil?
        age = row["Age/Date of Birth"].gsub("(", "@").gsub(")", "@")
        regex = /.*\@(.*)@/
        age = age.slice(regex, 1)
        year_of_birth = age.split(" ").last.to_i
      end

      salary = row["Annual Salary"].gsub("INR ", "").gsub(" L", "")
      education = row["U.G. Course"].nil? ? "" : row["U.G. Course"]
      education = education + "/" + row["P.G. Course"] unless row["P.G. Course"].nil?

      if candidate.nil?
        c = Candidate.create(first_name: first_name,
                             last_name: last_name,
                             email: row["Email"],
                             phone: row["Contact No."],
                             biography: row["Resume Title"],
                             location: row["Current Location"],
                             current_company: row["Current Employer"],
                             current_title: row["Designation"],
                             experience: experience,
                             source_id: 1,
                             bucket: "incomplete",
                             current_ctc: salary,
                             birth_year: year_of_birth,
                             user_id: 14,
                             owner_id: 14,
                             zoho_id: row["Candidate Id"],
                             role_id: row["Role Id"],
                             opening_id: 20,
                             highest_qualification: education)
        unless row["Created Time"].nil?
          Note.create(body: "Created in Zoho on " + row["Created Time"], user_id: 4, notable: c)
        end

        unless row["Comment 1"].nil?
          Note.create(body: row["Comment 1"], user_id: 4, notable: c)
        end
        unless row["Comment 2"].nil?
          Note.create(body: row["Comment 2"], user_id: 4, notable: c)
        end
        unless row["Comment 3"].nil?
          Note.create(body: row["Comment 3"], user_id: 4, notable: c)
        end
        unless row["Comment 4"].nil?
          Note.create(body: row["Comment 4"], user_id: 4, notable: c)
        end
        unless row["Comment 5"].nil?
          Note.create(body: row["Comment 5"], user_id: 4, notable: c)
        end
      end
    end
  end
end
