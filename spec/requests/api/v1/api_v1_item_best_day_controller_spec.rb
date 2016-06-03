require 'rails_helper'

RSpec.describe "Api::V1::Item::BestDayController", type: :request do
  describe "GET best day" do
    before(:each) do
      load_associations
      id = 2

      get "/api/v1/items/#{id}/best_day"
    end

     it "returns best day response" do
       expect(response).to have_http_status(200)
       expect(response).to be_success
     end

     it "returns the date with the most sales for the given item using the invoice date" do
       expect(response_body).to eq({:date=>"2012-03-27T14:53:59.000Z"})
       expect(response_body[:date].class).not_to eq(Date)
     end
  end
end
