require 'rails_helper'

describe "User sign out", type: :feature do
  subject { visit new_user_session_url }

  before do
    user = create(:user)
    subject
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_on "sign_in"
  end

  it "redirects to root path" do
    expect(page).to have_current_path(root_path)
  end
end
