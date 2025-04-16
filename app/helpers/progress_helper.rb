module ProgressHelper
  def display_campaign_progress(campaign)
    candidates = campaign.candidates
    total_candidates = candidates.count
    waiting_candidates = candidates.where(status: ["waiting_for_evaluation"]).count
    rejected_candidates = candidates.where(status: ["rejected_in_screening", "rejected_in_first_round", "rejected_in_second_round", "not_interested", "rejected_in_hr_round"]).count
    pipelined_candidates = candidates.where(status: ["interview_to_be_scheduled", "first_round_scheduled", "second_round_scheduled", "hr_round_scheduled"]).count
    selected_candidates = candidates.where(status: ["offer_to_be_made", "offer_made", "offer_accepted", "joined"]).count

    not_contactable = candidates.where(status: ["on_hold", "no_show", "not_contactable", "follow_up_needed"]).count
    html = ""
    if total_candidates > 0
      progress = ((waiting_candidates) / total_candidates.to_f) * 100
      html << "<div class='bg-blue-400 h-1.5' style='width: #{progress}%'></div>"
      progress = ((rejected_candidates) / total_candidates.to_f) * 100
      html << "<div class='bg-red-400 h-1.5' style='width: #{progress}%'></div>"
      progress = ((not_contactable) / total_candidates.to_f) * 100
      html << "<div class='bg-sky-400 h-1.5' style='width: #{progress}%'></div>"

      progress = ((pipelined_candidates) / total_candidates.to_f) * 100
      html << "<div class='bg-yellow-400 h-1.5' style='width: #{progress}%'></div>"
      progress = ((selected_candidates) / total_candidates.to_f) * 100
      html << "<div class='bg-green-400 h-1.5' style='width: #{progress}%'></div>"
    end
    html.html_safe
  end

  def display_campaign_numbers(campaign)
    display_campaign_numbers = ""
    campaign.candidates.reorder("").group(:status).count.each do |status, count|
      status_name = status.humanize
      status_count = count
      display_campaign_numbers << status_name + ": " + status_count.to_s + "<br>"
    end
    display_campaign_numbers.html_safe
  end
end
