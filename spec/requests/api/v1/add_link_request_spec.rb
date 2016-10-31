require 'rails_helper'

RSpec.describe 'Links Create endpoint', type: :request do
  context "as an authenticated user" do
    it 'should create a link' do
      user = create(:user)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      link_params = {
        title: 'Waldo Found!',
        url: 'https://google.com/whereiswaldo'
      }

      post "/api/v1/links", params: link_params

      expect(response.status).to eq(201)

      newest_link = Link.last

      expect(newest_link.title).to eq('Waldo Found!')
      expect(newest_link.url).to eq('https://google.com/whereiswaldo')
      expect(newest_link.read).to eq(false)

      get '/api/v1/links'

      all_links = JSON.parse(response.body, symbolize_names: :true)

      expect(all_links.count).to eq(1)
      expect(all_links.last[:title]).to eq('Waldo Found!')
      expect(all_links.last[:url]).to eq('https://google.com/whereiswaldo')
      expect(all_links.last[:read]).to eq(false)
    end
  end
end
