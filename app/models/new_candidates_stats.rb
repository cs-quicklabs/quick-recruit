class NewCandidatesStats
  attr_accessor :entries, :total

  def initialize(entries)
    @entries = entries
  end

  def total
    entries.size
  end

  def joined
    entries.where(status: :joined).size
  end

  def offered
    entries.where(status: [:joined, :offer_accepted, :offer_made, :offer_to_be_made]).size
  end

  def second_round
    entries.where(status: [:joined, :offer_accepted, :offer_made, :offer_to_be_made, :second_round_scheduled, :rejected_in_second_round, :hr_round_scheduled, :rejected_in_hr_round]).size
  end

  def first_round
    entries.where(status: [:joined, :offer_accepted, :offer_made, :offer_to_be_made, :second_round_scheduled, :rejected_in_second_round, :hr_round_scheduled, :rejected_in_hr_round, :first_round_scheduled, :rejected_in_first_round]).size
  end

  def pipeline
    entries.where(status: [:joined, :offer_accepted, :offer_made, :offer_to_be_made, :second_round_scheduled, :rejected_in_second_round, :hr_round_scheduled, :rejected_in_hr_round, :first_round_scheduled, :rejected_in_first_round, :waiting_for_evaluation, :interview_to_be_scheduled]).size
  end
end
