class Event < ApplicationRecord
  ACTIONS = ["add_candidate", "add_note", "update_bucket", "add_user", "send_email", "upload_resume", "delete_resume", "update_status", "update_owner", "update_joining", "add_report", "toggle_recycle"].freeze

  belongs_to :user
  belongs_to :eventable, polymorphic: true
  belongs_to :trackable, polymorphic: true

  validates_presence_of :eventable, :trackable, :user
  validates :action, inclusion: { in: ACTIONS }
end
