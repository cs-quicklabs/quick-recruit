class Report::NewCandidatesController < Report::BaseController
  def index
    entries = Candidate.new_candidates_query(candidates_filter_params)
    @openings = Opening.active
    @stats = NewCandidatesStats.new(entries)

    @sources = Source.all

    @pagy, @candidates = pagy_nil_safe(params, entries, items: LIMIT)
    render_partial("report/new_candidates/candidate", collection: @candidates, cached: false)
  end

  private

  def candidates_filter_params
    params.except(:commit).permit(*NewCandidatesFilter::KEYS)
  end
end
