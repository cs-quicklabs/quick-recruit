class Campaign < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "owner_id", optional: false
  has_and_belongs_to_many :candidates
end
