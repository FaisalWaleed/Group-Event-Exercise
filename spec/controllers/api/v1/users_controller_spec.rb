require 'rails_helper'
RSpec.describe Api::V1::UsersController do

describe "GET #index" do
    before do
      @user=User.create(name: "test",email: "email@gmail.com")
      get :index
    end
    it "returns https success" do
      expect(response).to have_http_status :success 
    end
    it "JSON body response contains expected user attributes" do
      json_response = JSON.parse response.body
      expect(json_response[0].keys()).to match_array ["id","name", "email","created_at","updated_at"]
    end
  end
  describe "PUT #update" do
    before do
        @user=User.create(name: "test",email: "email@gmail.com")
      put :update ,params: {"id": @user.id,"user":{"name": "updated name"}}
    end
    it "returns https success" do
      expect(response).to have_http_status :success 
    end
    it "JSON body response contains Updated User attributes" do
      json_response = JSON.parse response.body
      expect(json_response["name"]).to eq "updated name"
    end
  end
  describe "POST #create" do
    before do
      post :create ,params: {user: { name: "new user", email: "email@gmail.com"}}
    end
    it "returns https success" do
      expect(response).to have_http_status :success 
    end
    it "JSON body response contains name and email for newly created object" do
      json_response = JSON.parse response.body
      expect(json_response["name"]).to eq "new user"
      expect(json_response["email"]).to eq "email@gmail.com"
    end
  end
  describe "POST #destroy" do
    before do
        @user=User.create(name: "test",email: "email@gmail.com")
        delete :destroy ,params: {id: @user.id}
    end
    it "returns https success" do
      expect(response).to have_http_status :success 
    end
    it "JSON body response contains message 'User was successfully destroyed.'" do
      json_response = JSON.parse response.body
      expect(json_response["message"]).to eq "User was successfully destroyed."
    end
  end
end