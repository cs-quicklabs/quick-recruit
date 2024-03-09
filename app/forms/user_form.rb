class UserForm < Patterns::Form
  attribute :email, String
  attribute :password, String
  attribute :password_confirmation, String
  attribute :first_name, String
  attribute :last_name, String
  attribute :role, String

  validates :email, :password, :password_confirmation, :first_name, :last_name, :role, presence: true

  private

  def persist
    update_user
  end

  def update_user
    resource.update(attributes)
  end
end
