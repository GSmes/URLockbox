require "rails_helper"

RSpec.feature "Log Out" do
  scenario "they attempt to log out" do
    user = create(:user)

    visit root_path

    within("#login-form") do
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_button "Log In"
    end

    within("#topnavbar") do
      expect(page).to have_content("Logged in as #{user.email}")
      expect(page).to have_content("Log Out")
      expect(page).not_to have_content("Log In")
      expect(page).not_to have_content("Sign Up")
    end

    click_on "Log Out"

    expect(current_path).to eq(login_path)

    within("#topnavbar") do
      expect(page).to have_content("Log In")
      expect(page).to have_content("Sign Up")
      expect(page).not_to have_content("Logged in as #{user.email}")
      expect(page).not_to have_content("Log Out")
    end
  end
end
