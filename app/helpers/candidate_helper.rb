module CandidateHelper
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
    when "incomplete_profile", "unqualified", "other", "irrelevant", "moved_on"
      "gray"
    else
      "primary"
    end
  end
end
