class BucketReportStats
  attr_accessor :entries, :total

  def initialize(entries)
    @entries = entries
  end

  def total
    entries.size
  end

  def opening_stats
    stats = entries.unscope(:order).select(:opening_id).group(:opening_id).count
    opening_ids = stats.keys
    titles = Opening.where(id: opening_ids).pluck(:id, :title).to_h
    stats.map { |opening_id, count| { id: opening_id, title: titles[opening_id], count: count } }
  end

  def location_stats
    stats = entries.unscope(:order).select(:location).group(:location).count
    stats.map { |location, count| { location: location, count: count } }
  end

  def owner_stats
    stats = entries.unscope(:order).select(:owner_id).group(:owner_id).count
    owner_ids = stats.keys
    names = User.where(id: owner_ids).pluck(:id, :first_name).to_h
    stats.map { |owner_id, count| { id: owner_id, name: names[owner_id], count: count } }
  end

  def status_stats
    stats = entries.unscope(:order).select(:status).group(:status).count
    stats.map { |status, count| { status: status, count: count } }
  end
end
