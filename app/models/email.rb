class Email < ApplicationRecord
  belongs_to :candidate
  belongs_to :user

  enum kind: { rejection_email: 0, about_us_email: 1, job_description_email: 2, not_a_match_email: 3, f2f_detail_email: 4, position_closed_email: 5, send_resume_email: 6 }
  enum status: { pending: 0, sent: 1, failed: 2, delivered: 3, read: 4 }
end
