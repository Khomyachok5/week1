require 'rails_helper'

RSpec.describe SiteController, type: :controller do

  context "user successfully logged in" do
    let(:account) {create :account, user_logged_in: true}
    before (:each) do
      session[:email] = account.email
    end

    describe "GET #index" do
      before (:each) do
        get :index
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "logs account out" do
        expect(account.reload.user_logged_in).to be_falsey
      end
    end
  end

  context "user is not logged in" do
    describe "GET #index" do
      before (:each) do
        create :account
        get :index
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end
end