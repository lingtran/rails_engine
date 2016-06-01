require 'rails_helper'

RSpec.describe MerchantsController do
  describe "GET index" do
    get :index, format: :json

    expect(response).to eq(:success)
  end
end
