class CandidatesStats
  attr_accessor :entries, :total

  def initialize(entries)
    @entries = entries
  end

  def total
    entries.size
  end
end
