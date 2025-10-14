class Member::FeedbacksController < Member::BaseController
  before_action :set_feedback, only: %i[show edit update destroy]

  def index
    @feedbacks = Feedback.where(user: @member).includes(:user, :submitter).order(created_at: :desc)
  end

  def new
    @feedback = Feedback.new
  end

  def create
    feedback = AddFeedback.call(@member, current_user, feedback_params, params[:commit]).result
    if feedback.persisted?
      redirect_to member_feedbacks_path(@member), notice: "Feedback was created successfully"
    else
      redirect_to new_member_feedbacks_path(@member), alert: "Feedback was not created. Please try again."
    end
  end

  def update
    @feedback.update(feedback_params)
    redirect_to member_feedbacks_path(@member), notice: "Feedback was updated successfully"
  end

  def edit
  end

  def show
  end

  def destroy
  end

  private

  def set_feedback
    @feedback ||= Feedback.find(params[:id])
  end

  def feedback_params
    params.require(:feedback).permit(:title, :content, :nature, :status)
  end
end
