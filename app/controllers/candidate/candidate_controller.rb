class Candidate::CandidateController < Candidate::BaseController
  def update_bucket
    @candidate.update(bucket: params[:bucket])

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update(@candidate, partial: "candidate/bucket", locals: { candidate: @candidate }) }
    end
  end
end
