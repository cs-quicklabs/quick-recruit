# frozen_string_literal: true

class UpdateCandidatesFilter
  include ActiveModel::Model

  KEYS = %i[
    created_by
    source_id
    updated_after_date
    updated_before_date
    bucket
    status
    owner_id
    bucket_updated_after_date
    bucket_updated_before_date
  ].freeze

  attr_accessor(*KEYS)

  def initialize(params = {})
    params = params&.slice(*KEYS)
    super(params)
  end
end
