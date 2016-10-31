require "rails_helper"

RSpec.feature "user creates a link", js: true do
  it "displays the new link" do
    user = create(:user)
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit root_path

    within '#newLink' do
      fill_in 'title', with: "Blogger's Vlogger's Blog Post"
      fill_in 'url', with: "https://www.google.com/"
      click_on 'Add Link'
    end

    expect(current_path).to eq(root_path)

    within '#linksTable' do
      expect(page).to have_content("Blogger's Vlogger's Blog Post")
      expect(page).to have_content("https://www.google.com/")
    end
  end
end
