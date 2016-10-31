require "rails_helper"

RSpec.feature "Sign Up" do
  scenario "they are redirected to a form to create an account or sign in" do
    user = build(:user)

    visit root_path

    click_on "Log In or Sign Up"

    expect(current_path).to eq(new_user_path)

    within("#signup-form") do
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      fill_in "password_confirmation", with: user.password
      click_button "Sign Up"
    end

    within ".alert" do
      expect(page).to have_content("Account created successfully!")
    end

    expect(current_path).to eq(root_path)

    within("#topnavbar") do
      expect(page).to have_content("Logged in as #{user.email}")
      expect(page).to have_content("Log Out")
      expect(page).not_to have_content("Log In or Sign Up")
    end
  end
end
