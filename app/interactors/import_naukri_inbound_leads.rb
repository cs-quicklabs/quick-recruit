class ImportNaukriInboundLeads
  require "csv"

  def call(file, bucket, opening_id)
    opened_file = File.open(file)
    options = { headers: true, col_sep: "," }
    CSV.foreach(opened_file, **options) do |row|
      candidate = Candidate.find_by_email(row["Email ID"])
      first_name = row["Name"].split(" ").first
      last_name = ""

      if row["Name"].split(" ").length > 2
        last_name = row["Name"].split(" ").last(2).join(" ")
      else
        last_name = row["Name"].split(" ").last
      end

      experience = row["Total Experience"]
      experience = experience.gsub("Year(s) ", ".")
      experience = experience.gsub(" Month(s)", "")
      experience = experience.to_f

      year_of_birth = nil
      unless row["Date of Birth"].nil?
        year_of_birth = row["Date of Birth"].split("-").last.to_i
      end

      salary = row["Annual Salary"].gsub("Rs ", "").gsub(" Lakhs", "")
      education = row["Under Graduation degree"].nil? ? "" : row["Under Graduation degree"]
      education = education + "/" + row["Post graduation degree"] unless row["Post graduation degree"].nil?
      company = row["Curr. Company name"].nil? ? "" : row["Curr. Company name"]
      location = row["Current Location"].nil? ? "" : row["Current Location"]

      if candidate.nil?
        c = Candidate.create(first_name: first_name,
                             last_name: last_name,
                             email: row["Email ID"],
                             phone: row["Phone Number"],
                             biography: row["Resume Title"],
                             location: location,
                             current_company: company,
                             current_title: row["Curr. Company Designation"],
                             experience: experience,
                             source_id: 1,
                             bucket: bucket,
                             current_ctc: salary,
                             birth_year: year_of_birth,
                             user_id: 14,
                             owner_id: 14,
                             role_id: Opening.find(opening_id).role_id,
                             opening_id: opening_id,
                             highest_qualification: education,
                             notice_period: row["Notice period/ Availability to join"],
                             next_recycle_on: DateTime.now)
      else
        candidate.update(bucket: bucket, opening_id: opening_id, current_ctc: salary, experience: experience, current_company: company, location: location)
      end
    end
  end
end
