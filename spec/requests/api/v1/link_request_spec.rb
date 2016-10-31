require 'rails_helper'

RSpec.describe 'Links Endpoint', type: :request do
  context "as an authenticated user" do
    it 'should return a collection of all links' do
      user = create(:user)
      links = create_list(:link, 3, user: user)
      expected_link_1 = links.first
      expected_link_3 = links.last

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      get '/api/v1/links'

      expect(response.status).to eq(200)

      parsed_response = JSON.parse(response.body, symbolize_names: :true)
      first_link = parsed_response.first
      third_link = parsed_response.last

      expect(parsed_response.count).to eq(3)
      expect(first_link[:id]).to eq(expected_link_1.id)
      expect(first_link[:title]).to eq(expected_link_1.title)
      expect(first_link[:url]).to eq(expected_link_1.url)
      expect(first_link[:read]).to eq(expected_link_1.read)

      expect(third_link[:id]).to eq(expected_link_3.id)
      expect(third_link[:title]).to eq(expected_link_3.title)
      expect(third_link[:url]).to eq(expected_link_3.url)
      expect(third_link[:read]).to eq(expected_link_3.read)
    end
  end


  context "as an unauthenticated user" do
    it 'should not return any links' do
      get '/api/v1/links'

      expect(response).not_to be_success
    end
  end
end
