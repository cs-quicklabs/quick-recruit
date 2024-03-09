class SearchController < ApplicationController
  def candidates
    query = "%#{params[:q]}%".split(/\s+/)
    @candidates = candidates_matching_query(query)
    render layout: false
  end

  def candidates_matching_query(like_keyword)
    Candidate.where("first_name iLIKE ANY ( array[?] )", like_keyword)
      .or(Candidate.where("last_name iLIKE ANY ( array[?] )", like_keyword))
      .or(Candidate.where("email iLIKE ANY ( array[?] )", like_keyword))
      .order(:first_name).limit(7)
  end
end
