class Public::ApplyController < Public::PublicController
  def index
    @candidate = Candidate.new
  end

  def create
    CandidateMailer.with(content: candidate_params).lead_email.deliver_later
    redirect_to public_thanks_path, notice: "Thank you for applying!"
  end

  def thanks
  end

  private

  def candidate_params
    params.require(:candidate).permit(:first_name, :last_name, :email, :phone, :biography, :opening_id)
  end
end
