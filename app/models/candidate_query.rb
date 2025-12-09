# frozen_string_literal: true

class CandidateQuery
  def initialize(entries, params)
    @entries = entries.extending(Scopes)
    @params = params
  end

  def filter
    result = entries
    filter_params.each do |filter, value|
      result = result.public_send(filter, value) if present?(value)
    end
    result
  end

  private

  attr_reader :entries, :params

  def filter_params
    params&.reject { |_, v| v.nil? } || {}
  end

  def present?(value)
    value != "" && !value.nil?
  end

  module Scopes
    def role_id(param)
      where(role_id: param)
    end

    def opening_id(param)
      where(opening_id: param)
    end

    def user_id(param)
      where(user_id: param)
    end

    def bucket(param)
      where(bucket: param)
    end

    def owner_id(param)
      where(owner_id: param)
    end
  end
end
