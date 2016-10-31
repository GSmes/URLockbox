require 'rails_helper'

RSpec.describe 'Links Create endpoint', type: :request do
  context "as an authenticated user" do
    # it 'should return a collection of all links' do
    #   user = create(:user)
    #   links = create_list(:link, 3, user: user)
    #   expected_link_1 = links.first
    #   expected_link_3 = links.last
    #
    #   allow_any_instance_of(ApplicationController)
    #     .to receive(:current_user)
    #     .and_return(user)
    #
    #   get '/api/v1/links'
    #
    #   expect(response.status).to eq(200)
    #
    #   parsed_response = JSON.parse(response.body, symbolize_names: :true)
    #   first_link = parsed_response.first
    #   third_link = parsed_response.last
    #
    #   expect(parsed_response.count).to eq(3)
    #   expect(first_link[:id]).to eq(expected_link_1.id)
    #   expect(first_link[:title]).to eq(expected_link_1.title)
    #   expect(first_link[:url]).to eq(expected_link_1.url)
    #   expect(first_link[:read]).to eq(expected_link_1.read)
    #
    #   expect(third_link[:id]).to eq(expected_link_3.id)
    #   expect(third_link[:title]).to eq(expected_link_3.title)
    #   expect(third_link[:url]).to eq(expected_link_3.url)
    #   expect(third_link[:read]).to eq(expected_link_3.read)
    # end

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
