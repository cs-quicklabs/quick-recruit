class CampaignsController < BaseController
  before_action :set_campaign, only: %i[show edit update destroy close]

  def new
    @campaign = Campaign.new
    @owners = User.recruiters
  end

  def show
    @candidates = @campaign.candidates.includes(:opening, :owner)
    @candidates.order(updated_at: :desc)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def close
    @campaign.update(active: false)
    redirect_to campaigns_path, notice: "Sprint was closed successfully"
  end

  def create
    @campaign = Campaign.create(campaign_params)
    @campaign.save
    redirect_to campaigns_path, notice: "New Sprint was created successfully"
  end

  def index
    @campaigns = nil
    if current_user.admin?
      if params[:active].present?
        @campaigns = Campaign.includes(:owner).where(active: params[:active]).order(active: :desc, created_at: :asc)
      else
        @campaigns = Campaign.includes(:owner).all.order(active: :desc, created_at: :asc)
      end
    else
      @campaigns = Campaign.includes(:owner).where(owner: current_user, active: true).order(active: :desc, created_at: :asc)
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name, :owner_id)
  end

  def set_campaign
    @campaign ||= Campaign.find(params[:id])
  end
end
