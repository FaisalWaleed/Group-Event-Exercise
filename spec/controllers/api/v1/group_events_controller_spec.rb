require 'rails_helper'
RSpec.describe Api::V1::GroupEventsController do

describe "GET #index" do
    before do
      @user=User.create(name: "test",email: "email@gmail.com")
      @user.group_events.create(name: "Group Event")
      get :index,params: {:user_id=>@user.id}
    end
    it "returns https success" do
      expect(response).to have_http_status :success 
    end
    it "JSON body response contains expected user attributes" do
      json_response = JSON.parse response.body
      expect(json_response[0].keys()).to match_array ["id","name", "duration","description","started_at","ended_at","location"]
    end
  end
  describe "PUT #update" do
    before do
        @user=User.create(name: "test",email: "email@gmail.com")
        @user.group_events.create(name: "Group Event")
      put :update ,params: {"id": @user.group_events[0].id,"group_event":{"name": "updated name","description": "<div>updated</div>"}}
    end
    it "returns https success" do
      expect(response).to have_http_status :success 
    end
    it "JSON body response contains Updated Group Event attributes" do
      json_response = JSON.parse response.body
      expect(json_response["name"]).to eq "updated name"
      expect(json_response["description"]).to eq "<div>updated</div>"
    end
  end
  describe "POST #create" do
    before do
      @user=User.create(name: "test",email: "email@gmail.com")
      post :create ,params: {user_id: @user.id,group_event: {id: 1,name: "new group event"}}
    end
    it "returns https success" do
      expect(response).to have_http_status :success 
    end
    it "JSON body response contains id for newly created object" do
      json_response = JSON.parse response.body
      expect(json_response["id"]).to eq 1
    end
  end
  describe "POST #publish with incomplete GroupEvent" do
    before do
      @user=User.create(name: "test",email: "email@gmail.com")
      @group_event=GroupEvent.create(user_id: @user.id,
                                     name: "name",
                                     description: "<div> message </div>",
                                     started_at: "2020-11-04 11:25:00",
                                     ended_at: "2020-12-04 11:25:00")
      post :publish ,params: {id: @group_event.id,group_event: {id: 1,name: "new group event"}}
    end
    it "returns https success" do
      expect(response).to have_http_status :success 
    end
    it "JSON body response contains message for group event can not be published" do
      json_response = JSON.parse response.body
      expect(json_response["error"]).to eq "Group event can't  published. Please fill all fields."
    end
  end
  describe "POST #publish with complete GroupEvent" do
    before do
      @user=User.create(name: "test",email: "email@gmail.com")
      @group_event=GroupEvent.create(user_id: @user.id,
                                     name: "name",
                                     description: "<div> message </div>",
                                     started_at: "2020-11-04 11:25:00",
                                     ended_at: "2020-12-04 11:25:00",
                                     location: Location.create(state: "state",city: "city",street:"street",zipcode: "zipcode"))
      post :publish ,params: {id: @group_event.id,group_event: {id: 1,name: "new group event"}}
    end
    it "returns https success" do
      expect(response).to have_http_status :success 
    end
    it "JSON body response contains message GroupEvent published successfully" do
      json_response = JSON.parse response.body
      expect(json_response["message"]).to eq "Group event was successfully published."
    end
  end
  describe "Delete #destroy" do
    before do
      @user=User.create(name: "test",email: "email@gmail.com")
      @group_event=GroupEvent.create(user_id: @user.id,
                                     name: "name")
      delete :destroy ,params: {id: @group_event.id}
    end
    it "returns https success" do
      expect(response).to have_http_status :success 
    end
    it "JSON body response contains message 'Group Event was successfully deleted.' " do
      json_response = JSON.parse response.body
      @group_event.reload
      expect(json_response["message"]).to eq "Group Event was successfully deleted."
      expect(@group_event.deleted_at).not_to eq nil
    end
  end
end