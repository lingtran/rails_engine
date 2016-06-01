require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do
  describe "GET index" do
    get :index, format: :json

    expect(response).to eq(:success)
  end
end
