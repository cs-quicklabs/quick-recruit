class CampaignsController < BaseController
  before_action :set_campaign, only: %i[show edit update destroy close]

  def new
    @campaign = Campaign.new
    @owners = User.owners
  end

  def show
    @candidates = @campaign.candidates.includes(:opening, :owner).order(updated_at: :desc)
  end

  def edit
    @owners = User.owners

  end

  def update
    @campaign.update(campaign_params)
    redirect_to campaigns_path(active: true), notice: "Sprint was updated successfully"
  end

  def destroy
  end

  def close
    @campaign.update(active: false)
    redirect_to campaigns_path(active: true), notice: "Sprint was closed successfully"
  end

  def create
    @campaign = Campaign.create(campaign_params)
    @campaign.save
    redirect_to campaigns_path(active: true), notice: "New Sprint was created successfully"
  end

  def index
    @campaigns = current_user.admin_or_recruiter_admin? ? campaigns_for_admins : campaigns_for_current_user
  end

  private

  def campaigns_for_admins
    base_scope = Campaign.includes(:owner)
    filter_campaigns(base_scope)
  end

  def campaigns_for_current_user
    base_scope = Campaign.includes(:owner).where(owner: current_user)
    filter_campaigns(base_scope)
  end

  def filter_campaigns(scope)
    scope = scope.where(active: params[:active]) if params[:active].present?
    scope.order(created_at: :desc).limit(20)
  end

  def campaign_params
    params.require(:campaign).permit(:name, :owner_id, :start_date, :end_date, :active)
  end

  def set_campaign
    @campaign ||= Campaign.find(params[:id])
  end
end
