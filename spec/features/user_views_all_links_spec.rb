require "rails_helper"

RSpec.feature "user views all links", js: true do
  let!(:user) { create(:user) }
  let!(:user_links) { create_list(:link, 2, user: user) }
  let!(:other_links) { create_list(:link, 2) }

  it "displays all links that currently exist for the user" do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit root_path

    expect(current_path).to eq(root_path)

    user_links.each do |link|
      within "#link-#{link.id}" do
        expect(page).to have_content(link.title)
        expect(page).to have_content(link.url)
        expect(page).to have_content(link.read)
      end
    end

    other_links.each do |link|
      expect(page).not_to have_css("#link-#{link.id}")
    end
  end
end
