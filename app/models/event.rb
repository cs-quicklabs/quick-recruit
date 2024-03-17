class Event < ApplicationRecord
  ACTIONS = ["add_candidate", "add_note", "update_bucket", "add_user", "send_email"].freeze

  belongs_to :user
  belongs_to :eventable, polymorphic: true
  belongs_to :trackable, polymorphic: true

  validates_presence_of :eventable, :trackable, :user
  validates :action, inclusion: { in: ACTIONS }
end
