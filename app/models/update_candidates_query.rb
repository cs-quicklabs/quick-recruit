# frozen_string_literal: true

class UpdateCandidatesQuery
  def initialize(entries, params)
    @entries = entries.extending(Scopes)
    @params = params
  end

  def filter
    result = entries
    filter_params.each do |filter, value|
      result = result.public_send(filter, value) if present?(value)
    end
    result.order(updated_at: :desc)
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
    def source_id(param)
      where(source_id: param)
    end

    def created_by(param)
      where(user_id: param)
    end

    def owner_id(param)
      where(owner_id: param)
    end

    def bucket(param)
      where(bucket: param)
    end

    def status(param)
      where(status: param)
    end

    def updated_after_date(param)
      where("updated_at >= ?", Date.parse(param.to_s).beginning_of_day)
    end

    def updated_before_date(param)
      where("updated_at <= ?", Date.parse(param.to_s).end_of_day)
    end
  end
end
