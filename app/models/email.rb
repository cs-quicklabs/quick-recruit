class Email < ApplicationRecord
  belongs_to :candidate
  belongs_to :user

  enum kind: { rejection_email: 0, about_us_email: 1, job_description_email: 2 }
  enum status: { pending: 0, sent: 1, failed: 2, delivered: 3, read: 4 }
end
