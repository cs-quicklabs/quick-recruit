class Opening::AssociationsController < Opening::BaseController
  before_action :set_opening

  def index
    @champions = @opening.candidates.where(bucket: :champions)
  end
end
