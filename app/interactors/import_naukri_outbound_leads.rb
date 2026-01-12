class ImportNaukriOutboundLeads
  require "csv"

  def call(file, bucket, opening_id)
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
      company = row["Current Employer"].nil? ? "" : row["Current Employer"]

      if candidate.nil?
        c = Candidate.create(first_name: first_name,
                             last_name: last_name,
                             email: row["Email"],
                             phone: row["Contact No."],
                             biography: row["Resume Title"],
                             location: row["Current Location"],
                             current_company: company,
                             current_title: row["Designation"],
                             experience: experience,
                             source_id: 1,
                             bucket: bucket,
                             current_ctc: salary,
                             birth_year: year_of_birth,
                             user_id: 14,
                             owner_id: 14,
                             zoho_id: row["Candidate Id"],
                             role_id: row["Role Id"].nil? ? 15 : row["Role Id"],
                             opening_id: opening_id,
                             highest_qualification: education,
                             next_recycle_on: DateTime.now)
      else
        candidate.update(bucket: bucket, opening_id: opening_id, current_ctc: salary, experience: experience, current_company: company)
      end
    end
  end
end
