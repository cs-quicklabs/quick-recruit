class Candidate::CandidateController < Candidate::BaseController
  def update_bucket
    candidate = UpdateBucket.call(@candidate, params[:bucket], current_user).result

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update(@candidate, partial: "candidate/bucket", locals: { candidate: @candidate }) }
    end
  end
end
