# frozen_string_literal: true

class BucketReportFilter
  include ActiveModel::Model

  KEYS = %i[
    location
    bucket
    status
    owner_id
    opening_id
  ].freeze

  attr_accessor(*KEYS)

  def initialize(params = {})
    params = params&.slice(*KEYS)
    super(params)
  end
end
