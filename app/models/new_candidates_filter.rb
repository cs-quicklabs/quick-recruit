# frozen_string_literal: true

class NewCandidatesFilter
  include ActiveModel::Model

  KEYS = %i[
    created_by
    source_id
    created_after_date
    created_before_date
    bucket
    status
    opening_id
  ].freeze

  attr_accessor(*KEYS)

  def initialize(params = {})
    params = params&.slice(*KEYS)
    super(params)
  end
end
