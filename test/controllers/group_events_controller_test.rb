require 'test_helper'

class GroupEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_event = group_events(:one)
  end

  test "should get index" do
    get group_events_url
    assert_response :success
  end

  test "should get new" do
    get new_group_event_url
    assert_response :success
  end

  test "should create group_event" do
    assert_difference('GroupEvent.count') do
      post group_events_url, params: { group_event: { deleted_at: @group_event.deleted_at, ended_at: @group_event.ended_at, latitude: @group_event.latitude, longitude: @group_event.longitude, name: @group_event.name, started_at: @group_event.started_at, user_id: @group_event.user_id } }
    end

    assert_redirected_to group_event_url(GroupEvent.last)
  end

  test "should show group_event" do
    get group_event_url(@group_event)
    assert_response :success
  end

  test "should get edit" do
    get edit_group_event_url(@group_event)
    assert_response :success
  end

  test "should update group_event" do
    patch group_event_url(@group_event), params: { group_event: { deleted_at: @group_event.deleted_at, ended_at: @group_event.ended_at, latitude: @group_event.latitude, longitude: @group_event.longitude, name: @group_event.name, started_at: @group_event.started_at, user_id: @group_event.user_id } }
    assert_redirected_to group_event_url(@group_event)
  end

  test "should destroy group_event" do
    assert_difference('GroupEvent.count', -1) do
      delete group_event_url(@group_event)
    end

    assert_redirected_to group_events_url
  end
end
