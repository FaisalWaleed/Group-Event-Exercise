class GroupEventsController < ApplicationController
  before_action :set_group_event, only: [:show, :edit, :update, :destroy, :publish]
  before_action :load_user
  def index
    @group_events = GroupEvent.all
  end

  def show
  end

  def new
    @group_event = @user.group_events.new
    @group_event.build_location
  end

  def edit
  end

  def create
    @group_event = @user.group_events.new(group_event_params)

    respond_to do |format|
      if @group_event.save!
        format.html { redirect_to @user, notice: 'Group event was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @group_event.update! group_event_params
        format.html { redirect_to @user, notice: 'Group event was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
  def destroy
    @group_event.deleted_at = Time.now
    @group_event.save!
    respond_to do |format|
      format.html { redirect_to @user, notice: 'Group event was successfully destroyed.' }
    end
  end

  def publish
    if @group_event.publish_able?
      @group_event.update(publish: true)
      respond_to do |format|
        format.html { redirect_to user_group_event_path(@user,@group_event), notice: 'Group event was successfully published.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to user_group_event_path(@user,@group_event), alert: "Group event can't  published. Please fill all fields." }
      end
    end
  end
  private
    def load_user
      @user = User.find(params["user_id"])
    end

    def set_group_event
      @group_event = GroupEvent.find(params[:id])
    end

    def group_event_params
      params.require(:group_event).permit(
        :id,
        :name,
        :user_id,
        :started_at,
        :ended_at,
        :description,
        location_attributes: [
          :state,
          :city,
          :street,
          :zipcode
        ]
      )
    end
end
