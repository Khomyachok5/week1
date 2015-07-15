require 'rails_helper'

RSpec.describe SiteController, type: :controller do

  context "user successfully logged in" do
    before (:each) do
      session[:UserLoggedIn] = true
    end

    describe "GET #index" do
      before (:each) do
        get :index
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "logs account out" do
        expect(session[:UserLoggedIn]).to be_falsey
      end
    end
  end

  context "user is not logged in" do
    describe "GET #index" do
      before (:each) do
        get :index
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end
end