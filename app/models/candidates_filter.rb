# frozen_string_literal: true

class CandidatesFilter
  include ActiveModel::Model

  KEYS = %i[
    bucket
    role_id
    opening_id
    user_id
    owner_id
    bucket
  ].freeze

  attr_accessor(*KEYS)

  def initialize(params = {})
    params = params&.slice(*KEYS)
    super(params)
  end
end
