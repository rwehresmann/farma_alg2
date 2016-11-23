require 'rails_helper'

describe "User sign in", type: :feature do
  subject { visit new_user_session_url }

  context "when user is registered" do
    before do
      user = create(:user)
      subject
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_on "sign_in"
    end

    it "redirects to root path" do
      expect(page).to have_current_path(authenticated_root_path)
    end
  end

  context "when user is not registered" do
    before { subject }

    it "not redirects to another page" do
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
