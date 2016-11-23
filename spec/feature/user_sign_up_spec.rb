require 'rails_helper'

describe "User sign out", type: :feature do
  subject(:fill_data) do
    visit new_user_registration_url
    fill_in "user_name", with: "Name"
    fill_in "user_email", with: "email@mail.com"
    page.check("user_prof")
    fill_in "user_password", with: "foobar"
    fill_in "user_password_confirmation", with: "foobar"
  end

  context "whit valid attributes" do
    before do
      fill_data
      click_on "sign_up"
    end

    it "creates the user" do
      expect(User.count).to eq(1)
    end

    it "sets as professor" do
      expect(User.first.prof).to be_truthy
    end

    it "redirects to root path" do
      expect(page).to have_current_path(root_path)
    end
  end

  context "whit invalid attributes" do
    before do
      visit new_user_registration_url
      click_on "sign_up"
    end

    it "render validation errors" do
      errors_count = find("h2").text.split(" ").first.to_i
      expect(errors_count).to eq(3)
    end

    context "when emails doesn't match" do
      before do
        visit new_user_registration_url
        fill_data
        fill_in "user_password_confirmation", with: "barfoo"
        click_on "sign_up"
      end

      it "render validation error" do
        errors_count = find("h2").text.split(" ").first.to_i
        expect(errors_count).to eq(1)
      end
    end
  end

  context "whit passwords that not match" do

  end
end
