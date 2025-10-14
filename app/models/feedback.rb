class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :submitter, class_name: "User", foreign_key: "submitter_id"
  has_rich_text :content

  enum :status, draft: 0, submitted: 1
  enum :nature, positive: 0, negative: 1, neutral: 2
end
