class ImportCandidate
  require "csv"

  def call(file)
    opened_file = File.open(file)
    options = { headers: true, col_sep: "," }
    CSV.foreach(opened_file, **options) do |row|
      puts row.to_hash
      candidate = Candidate.find_by_email(row["Email"])
      if candidate.nil?
        first_name = row["First Name"].nil? ? "." : row["First Name"]
        last_name = row["Last Name"].nil? ? "." : row["Last Name"]
        email = row["Email"].nil? ? "." : row["Email"]
        phone = row["Phone"].nil? ? row["Mobile"] : (row["Phone"] + "," + (row["Mobile"].nil? ? "" : row["Mobile"]))
        phone = phone.nil? ? "." : phone
        c = Candidate.create(first_name: first_name, last_name: last_name, email: email, phone: phone, location: row["City"], current_company: row["Current Employer"], current_title: row["Current Title"], experience: row["Experience in Years"], source_id: 4, bucket: "incomplete", current_ctc: row["Current Salary"], expected_ctc: row["Expected Salary"], notice_period: row["Notice Period"], user_id: 4, zoho_id: row["Candidate Id"], role_id: 15, opening_id: 20)
        unless row["Created Time"].nil?
          Note.create(body: "Created in Zoho on " + row["Created Time"], user_id: 4, notable: c)
        end

        unless row["Skill Set"].nil?
          Note.create(body: row["Skill Set"], user_id: 4, notable: c)
        end
        unless row["Additional Info"].nil?
          Note.create(body: row["Additional Info"], user_id: 4, notable: c)
        end
        unless row["Candidate Status"].nil?
          Note.create(body: row["Candidate Status"], user_id: 4, notable: c)
        end
      end
    end
  end
end
