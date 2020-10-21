require 'rails_helper'

RSpec.describe "Refrigerators", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/refrigerators/index"
      expect(response).to have_http_status(:success)
    end
  end

end
