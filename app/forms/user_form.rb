class UserForm < Patterns::Form
  attribute :email, String
  attribute :password, String
  attribute :password_confirmation, String
  attribute :name, String
  attribute :role, String

  validates :email, :password, :password_confirmation, :name, :role, presence: true

  private

  def persist
    update_user
  end

  def update_user
    resource.update(attributes)
  end
end
