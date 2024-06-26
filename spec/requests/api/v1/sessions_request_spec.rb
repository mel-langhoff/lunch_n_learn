require 'rails_helper'

RSpec.describe "Sessions Api" do
  before :each do
    host! 'localhost:3000'

    @user = User.create!(    
      email: "blah2@jaja.com",
      name: "Blahblah2",
      password: "test",
      password_confirmation: "test"
    )

    @session_params = 
    { 
      email: @user.email, 
      password: "test" 
    }
  end

  describe "/api/v1/sessions" do
    it "can create a session" do
      # params is used to pass parameters to the request body, not to the URL
      post "/api/v1/sessions", params: @session_params.to_json, headers: { 'Content-Type': 'application/json' } 

      expect(response).to have_http_status(:ok)

      # Use strings, not symbols, to access JSON keys in response bodies, as JSON parsing converts keys to strings by default.
      # forgot to symbolize the names
      json_response = JSON.parse(response.body)
      expect(json_response["data"]["type"]).to eq("user")
      expect(json_response["data"]["attributes"]["name"]).to eq(@user.name)
      expect(json_response["data"]["attributes"]["email"]).to eq(@user.email)
      expect(json_response["data"]["attributes"]["api_key"]).to eq(@user.api_key)
    end
  end
end
