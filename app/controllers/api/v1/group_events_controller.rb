class Api::V1::GroupEventsController < ApplicationController
  before_action :set_group_event, only: [:show, :update, :destroy,:publish]
  before_action :load_user, only: [:index,:create]
  skip_before_action :verify_authenticity_token
  before_action :redirect_back_if_unauthorized
  
  def index
    @group_events = @user.group_events
    render json: @group_events.map(&:to_object)
  end

  def show
    render json: @group_event.to_object
  end

  def create
    @group_event = @user.group_events.new(group_event_params)
    if @group_event.save
      render json: @group_event.to_object, status: :created
    else
      render json: @group_event.errors, status: :unprocessable_entity
    end
  end

  def update
    if @group_event.update(group_event_params)
      render json: @group_event.to_object
    else
      render json: @group_event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @group_event.deleted_at = Time.now
    if @group_event.save
      render json: {message: "Group Event was successfully deleted."}
    else
      render json: {message: "Can't delete Group Event."}
    end
  end

  def publish
    if @group_event.publish_able?
      @group_event.update(publish: true)
      render json: {"message": "Group event was successfully published."}
    else
      render json: {"error": "Group event can't  published. Please fill all fields."}
    end
  end
  private
    def load_user
      @user = User.where(id: params["user_id"]).first
      unless @user.present?
        render json: {error: "User not find with id "+params[:user_id]+" ."}
      end  
    end

    def set_group_event
      @group_event = GroupEvent.where(id: params[:id]).first
      unless @group_event.present?
        render json: {error: "Group Event not find with id "+params[:id]+" ."}
      end
    end

    def group_event_params
      params.require(:group_event).permit(
        :id,
        :name,
        :user_id,
        :started_at,
        :ended_at,
        :description,
        :secret,
        location_attributes: [
          :state,
          :city,
          :street,
          :zipcode
        ]
      )
    end

    def redirect_back_if_unauthorized
      if group_event_params[:secret].nil? || group_event_params[:secret] != @group_event.secret
        render json: {error: "Unauthorized, Please provide correct secret."}
    end
end
