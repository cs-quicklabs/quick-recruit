class Report::UpdateCandidatesController < Report::BaseController
  def index
    entries = Candidate.update_candidates_query(candidates_filter_params)
    @stats = CandidatesStats.new(entries)

    @sources = Source.all

    @pagy, @candidates = pagy_nil_safe(params, entries, items: LIMIT)
    render_partial("report/update_candidates/candidate", collection: @candidates, cached: false)
  end

  private

  def candidates_filter_params
    params.except(:commit).permit(*UpdateCandidatesFilter::KEYS)
  end
end
