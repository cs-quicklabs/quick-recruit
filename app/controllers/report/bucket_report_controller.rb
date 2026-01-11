class Report::BucketReportController < Report::BaseController

  def index
    entries = Candidate.bucket_report_query(candidates_filter_params)
    @bucket = params[:bucket]
    @stats = BucketReportStats.new(entries)

    @pagy, @candidates = pagy_nil_safe(params, entries, items: LIMIT)
    render_partial("report/update_candidates/candidate", collection: @candidates, cached: false)
  end

  private

  def candidates_filter_params
    params.except(:commit).permit(*BucketReportFilter::KEYS)
  end
end
