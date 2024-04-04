module CandidateHelper

  #enum bucket: { recent: 0, hot: 1, pipeline: 2, champions: 3, joinings: 4, icebox: 5, archive: 6, incomplete: 7 }
  #enum :status, [:waiting_for_evaluation, :interview_to_be_scheduled, :first_round_scheduled, :second_round_scheduled, :hr_round_scheduled, :offer_to_be_made, :offer_made, :offer_accepted, :offer_declined, :offer_withdrawn, :joined, :on_hold, :incomplete_profile, :no_show, :not_interested, :not_contactable, :follow_up_needed, :rejected_in_screening, :rejected_in_first_round, :rejected_in_second_round, :rejected_in_hr_round, :unqualified, :other, :irrelevant]

  def status_color(status)
    case status
    when "rejected_in_screening", "rejected_in_first_round", "rejected_in_second_round", "rejected_in_hr_round", "not_interested"
      "red"
    when "offer_withdrawn", "offer_declined"
      "fuchsia"
    when "interview_to_be_scheduled", "first_round_scheduled", "second_round_scheduled", "hr_round_scheduled"
      "yellow"
    when "no_show", "not_contactable", "follow_up_needed", "on_hold"
      "sky"
    when "offer_to_be_made", "offer_made", "offer_accepted", "offer_declined", "joined"
      "green"
    when "incomplete_profile", "unqualified", "other", "irrelevant"
      "gray"
    else
      "primary"
    end
  end
end
