class Member::ReportsController < Member::BaseController
  before_action :set_report, only: %i[show edit update destroy]

  def index
    @reports = Report.where(user: @member).includes(:user, :submitter).order(created_at: :desc)
  end

  def new
    @report = Report.new
  end

  def create
    report = AddReport.call(@member, current_user, report_params, params[:commit]).result
    if report.persisted?
      redirect_to member_reports_path(@member), notice: "Report was created successfully"
    else
      redirect_to new_member_reports_path(@member), alert: "Report was not created. Please try again."
    end
  end

  def update
    @report.update(report_params)
    if params[:commit] == "submitted"
      @report.submitted!
    elsif params[:commit] == "draft"
      @report.draft!
    end
    redirect_to member_reports_path(@member), notice: "Report was updated successfully"
  end

  def edit
  end

  def show
  end

  def destroy
  end

  private

  def set_report
    @report ||= Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content, :nature, :status)
  end
end
