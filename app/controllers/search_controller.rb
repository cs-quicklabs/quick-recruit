class SearchController < BaseController
  def candidates
    query = "%#{params[:q]}%"
    @candidates = candidates_matching_query(query)
    render layout: false
  end

  def candidates_matching_query(like_keyword)
    Candidate.where("CONCAT_WS(' ', first_name, last_name) iLIKE ?", like_keyword)
      .or(Candidate.where("email iLIKE ?", like_keyword))
      .order(:first_name).limit(7)
  end
end
