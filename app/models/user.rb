class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  normalizes :email, with: ->(email) { email.strip.downcase }

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  has_one_attached :avatar
  validate :avatar_content_type
  validate :avatar_size

  def avatar_size
    if avatar.attached? && avatar.blob.byte_size > 1.megabytes
      errors.add(:avatar, "size should not be more than 1MB")
    end
  end

  def avatar_content_type
    if avatar.attached? && !avatar.content_type.in?(%w(image/jpeg image/png))
      errors.add(:avatar, "must be a JPEG or PNG")
    end
  end
end
