class CampaignsController < BaseController
  before_action :set_campaign, only: %i[show edit update destroy close]

  def new
    @campaign = Campaign.new
    @owners = User.owners
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
    redirect_to campaigns_path(active: true), notice: "Sprint was closed successfully"
  end

  def create
    @campaign = Campaign.create(campaign_params)
    @campaign.save
    redirect_to campaigns_path(active: true), notice: "New Sprint was created successfully"
  end

  def index
    @campaigns = current_user.admin_or_recruiter_admin? ? campaings_for_admins : campaigns_for_current_user
  end

  private

  def campaings_for_admins
    @campaigns = nil
    if params[:active].present?
      @campaigns = Campaign.includes(:owner).where(active: params[:active]).order(created_at: :desc)
    else
      @campaigns = Campaign.includes(:owner).all.order(created_at: :desc).limit(20)
    end
    return @campaigns
  end

  def campaigns_for_current_user
    @campaigns = nil
    if params[:active].present?
      @campaigns = Campaign.includes(:owner).where(owner: current_user, active: params[:active]).order(created_at: :desc)
    else
      @campaigns = Campaign.includes(:owner).where(owner: current_user).order(created_at: :desc).limit(20)
    end
    return @campaigns
  end

  def campaign_params
    params.require(:campaign).permit(:name, :owner_id, :start_date, :end_date, :active)
  end

  def set_campaign
    @campaign ||= Campaign.find(params[:id])
  end
end
