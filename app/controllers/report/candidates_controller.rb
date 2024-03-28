class Report::CandidatesController < Report::BaseController
  def index
    entries = Candidate.query(candidates_filter_params).order(created_at: :desc)
    @stats = CandidatesStats.new(entries)

    @roles = Role.all
    @openings = Opening.all

    @pagy, @candidates = pagy_nil_safe(params, entries, items: LIMIT)
    render_partial("report/candidates/candidate", collection: @candidates, cached: false)
  end

  private

  def candidates_filter_params
    params.except(:commit).permit(*CandidatesFilter::KEYS)
  end
end
