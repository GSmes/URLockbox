require "rails_helper"

RSpec.feature "Log In" do
  scenario "they log in with valid credentials" do
    user = create(:user)

    visit root_path

    expect(current_path).to eq(login_path)

    within("#login-form") do
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_button "Log In"
    end

    within ".alert" do
      expect(page).to have_content("Successfully logged in!")
    end

    expect(current_path).to eq(root_path)

    within("#topnavbar") do
      expect(page).to have_content("Logged in as #{user.email}")
      expect(page).to have_content("Log Out")
      expect(page).not_to have_content("Log In")
      expect(page).not_to have_content("Sign Up")
    end
  end
end
