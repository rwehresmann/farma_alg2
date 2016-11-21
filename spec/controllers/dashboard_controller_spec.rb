require 'rails_helper'

describe DashboardController, type: :controller do
  describe "Get #home" do
    before { get :home }

    it "renders home view" do
      expect(response).to render_template(:home)
    end
  end
end
