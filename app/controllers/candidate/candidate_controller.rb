class Candidate::CandidateController < Candidate::BaseController
  def update_bucket
    authorize @candidate
    candidate = UpdateBucket.call(@candidate, params[:bucket], current_user).result

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(candidate, partial: "candidate/bucket", locals: { candidate: candidate }) }
    end
  end

  def update_status
    authorize @candidate
    candidate = UpdateStatus.call(@candidate, params[:status], current_user).result

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("status_candidate_" + candidate.id.to_s, partial: "candidate/status", locals: { candidate: candidate }) }
    end
  end

  def update_owner
    authorize @candidate
    owner = User.find(params[:owner_id])
    candidate = UpdateOwner.call(@candidate, owner, current_user).result

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("owner_candidate_" + candidate.id.to_s, partial: "candidate/owner", locals: { candidate: candidate }) }
    end
  end

  def update_joining
    authorize @candidate
    candidate = UpdateJoining.call(@candidate, params[:joining_date], current_user).result

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("joining_candidate_" + candidate.id.to_s, partial: "candidate/joining", locals: { candidate: candidate }) }
    end
  end

  def update_recycle
    authorize @candidate
    candidate = UpdateRecycle.call(@candidate, params[:next_recycle_on], current_user).result

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("recycle_date_candidate_" + candidate.id.to_s, partial: "candidate/recycle_date", locals: { candidate: candidate }) }
    end
  end

  def update_campaign
    authorize @candidate
    candidate = UpdateCampaign.call(@candidate, params[:campaign_id], current_user).result

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("campaign_candidate_" + candidate.id.to_s, partial: "candidate/campaign", locals: { candidate: candidate }) }
    end
  end

  def reject_and_icebox
    redirect_path = @candidate.bucket == "hot" ? hot_candidates_path : leads_candidates_path

    RejectAndIceboxLead.call(@candidate, current_user)
    redirect_to redirect_path, notice: "Candidate rejected in screening and moved to icebox"
  end

  def reward_to_recruiter
    recruiter = User.find(params[:recruiter_id])
    RewardCandidateToRecruiter.call(@candidate, recruiter, current_user)

    redirect_to candidate_timeline_path(@candidate), notice: "Candidate was awarded to #{recruiter.name}"
  end

  def toggle_recycle
    authorize @candidate
    candidate = ToggleRecycle.call(@candidate, current_user).result

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("recycle_candidate_" + candidate.id.to_s, partial: "candidate/recycle", locals: { candidate: candidate }) }
    end
  end

  def edit_joining
    @candidate = Candidate.find(params[:candidate_id])
  end

  def edit_recycle
    @candidate = Candidate.find(params[:candidate_id])
  end
end
