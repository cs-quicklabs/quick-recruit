class Public::ApplyController < Public::PublicController
  def index
    @candidate = Candidate.new
  end

  def create
    ApplyForJob.call(candidate_params)
    redirect_to public_thanks_path, notice: "Thank you for applying!"
  end

  def thanks
  end

  private

  def candidate_params
    params.require(:candidate).permit(:first_name, :last_name, :email, :phone, :biography, :opening_id, :location, :birth_year, :current_title, :current_company, :current_ctc, :expected_ctc, :notice_period, :experience, :highest_qualification)
  end
end
