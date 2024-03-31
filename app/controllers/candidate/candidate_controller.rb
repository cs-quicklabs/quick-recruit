class Candidate::CandidateController < Candidate::BaseController
  def update_bucket
    authorize @candidate
    candidate = UpdateBucket.call(@candidate, params[:bucket], current_user).result

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update(candidate, partial: "candidate/bucket", locals: { candidate: candidate }) }
    end
  end

  def update_status
    authorize @candidate
    candidate = UpdateStatus.call(@candidate, params[:status], current_user).result

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update("status_candidate_" + candidate.id.to_s, partial: "candidate/status", locals: { candidate: candidate }) }
    end
  end
end
