require 'rails_helper'

RSpec.describe "Doctors", type: :request do
  let(:valid_attributes) do {
    name: 'Strange', 
    crm: '1234',
    crm_uf: "SP"
  }
  end

  describe "GET /index" do
    it "returns http success" do
      doctor = Doctor.new(valid_attributes)
      doctor.save
      get doctors_url
      expect(response).to be_successful
    end
  end
  # describe "GET /index" do
  #   it "returns http success" do
  #     get "/doctors/index"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /create" do
  #   it "returns http success" do
  #     get "/doctors/create"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /new" do
  #   it "returns http success" do
  #     get "/doctors/new"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /edit" do
  #   it "returns http success" do
  #     get "/doctors/edit"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /show" do
  #   it "returns http success" do
  #     get "/doctors/show"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /update" do
  #   it "returns http success" do
  #     get "/doctors/update"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /destroy" do
  #   it "returns http success" do
  #     get "/doctors/destroy"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
