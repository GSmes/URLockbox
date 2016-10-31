require 'rails_helper'

RSpec.describe 'Links Create endpoint', type: :request do
  context "as an authenticated user" do
    it 'should update a link' do
      user = create(:user)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      links = create_list(:link, 2, user: user)
      original_link  = links.first
      unedited_link = links.last

      expect(Link.where(id: original_link.id, title: original_link.title)).to exist

      link_params = {
        title: 'New Title',
        url: 'https://google.com/3',
        read: true
      }

      put "/api/v1/links/#{original_link.id}", params: link_params

      expect(response.status).to eq(200)

      updated_link = Link.find(original_link.id)

      expect(updated_link.title).to eq('New Title')
      expect(updated_link.title).to_not eq(original_link.title)
      expect(updated_link.url).to eq('https://google.com/3')
      expect(updated_link.url).to_not eq(original_link.url)
      expect(updated_link.read).to eq(true)
      expect(updated_link.read).to_not eq(original_link.read)
    end
  end
end
