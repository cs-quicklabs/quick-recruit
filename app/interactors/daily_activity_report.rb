class DailyActivityReport < Patterns::Service
  def call
    User.recruiters.each do |recruiter|
      RecruiterMailer.with(recruiter: recruiter,
                           new_candidates_count: new_candidates_count(recruiter),
                           updated_candidates_count: updated_candidates_count(recruiter),
                           new_candidates_daily_report_url: new_candidates_daily_report_url(recruiter),
                           updated_candidates_daily_report_url: updated_candidates_daily_report_url(recruiter))
        .daily_activity_report_email.deliver_later
    end
  end

  private

  def new_candidates_count(recruiter)
    params = { created_by: recruiter.id.to_s, created_after_date: Date.yesterday.to_formatted_s(:db), created_before_date: Date.yesterday.to_formatted_s(:db) }

    Candidate.new_candidates_query(params).count
  end

  def updated_candidates_count(recruiter)
    params = { created_by: recruiter.id.to_s, updated_after_date: Date.yesterday.to_formatted_s(:db), updated_before_date: Date.yesterday.to_formatted_s(:db) }

    Candidate.update_candidates_query(params).count
  end

  def new_candidates_daily_report_url(recruiter)
    "#{Rails.application.config.default_url_options[:host]}/report/new_candidates?created_by=#{recruiter.id.to_s}&created_after_date=#{Date.yesterday.to_formatted_s(:db)}&created_before_date=#{Date.yesterday.to_formatted_s(:db)}"
  end

  def updated_candidates_daily_report_url(recruiter)
    "#{Rails.application.config.default_url_options[:host]}/report/update_candidates?created_by=#{recruiter.id.to_s}&updated_after_date=#{Date.yesterday.to_formatted_s(:db)}&updated_before_date=#{Date.yesterday.to_formatted_s(:db)}"
  end
end
