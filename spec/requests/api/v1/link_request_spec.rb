require 'rails_helper'

RSpec.describe 'Links Endpoint', :type => :request do
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

    # it 'should update a link' do
    #   links = create_list(:link, 2)
    #   original_link  = links.first
    #   unedited_link = links.last
    #
    #   expect(Link.where(id: original_link.id, title: original_link.title)).to exist
    #
    #   link_params = {
    #     title: 'New Title',
    #     url: 'https://google.com/3',
    #     read: true
    #   }
    #
    #   put "/api/v1/links/#{original_link.id}", params: link_params
    #
    #   expect(response.status).to eq(204)
    #
    #   updated_link = Link.find(original_link.id)
    #
    #   expect(updated_link.title).to eq('New Title')
    #   expect(updated_link.title).to_not eq(original_link.title)
    #   expect(updated_link.url).to eq('https://google.com/3')
    #   expect(updated_link.url).to_not eq(original_link.url)
    #   expect(updated_link.read).to eq(true)
    #   expect(updated_link.read).to_not eq(original_link.read)
    #
    #   get '/api/v1/links'
    #
    #   all_links = JSON.parse(response.body, symbolize_names: :true)
    #
    #   expect(all_links.count).to eq(2)
    #   expect(all_links.first[:title]).to eq(unedited_link[:title])
    #   expect(all_links.first[:url]).to eq(unedited_link[:url])
    #   expect(all_links.first[:read]).to eq(unedited_link[:read])
    #   expect(all_links.last[:title]).to eq('New Title')
    #   expect(all_links.last[:url]).to eq('https://google.com/3')
    #   expect(all_links.last[:read]).to eq(true)
    # end
  end


  context "as an unauthenticated user" do
    it 'should not return any links' do
      get '/api/v1/links'

      expect(response).not_to be_success
    end

    # it 'should not update a link' do
    #   link = create(:link)
    #
    #   link_params = {
    #     title: 'Original Title',
    #     url: 'New Title'
    #   }
    #
    #   put "/api/v1/links/#{link.id}", params: link_params
    #
    #   expect(response).not_to be_success
    # end
  end
end
