class DailyActivityReport < Patterns::Service
  def call
    User.recruiters.each do |recruiter|
      params = { created_by: recruiter.id.to_s, created_after_date: Date.yesterday.to_formatted_s(:db), created_before_date: Date.yesterday.to_formatted_s(:db) }
      count = Candidate.new_candidates_query(params).count

      daily_report_url = "#{Rails.application.config.default_url_options[:host]}/report/new_candidates?created_by=#{recruiter.id.to_s}&created_after_date=#{Date.yesterday.to_formatted_s(:db)}&created_before_date=#{Date.yesterday.to_formatted_s(:db)}"
      RecruiterMailer.with(recruiter: recruiter, count: count, daily_report_url: daily_report_url).daily_activity_report_email.deliver_later
    end
  end
end
