require 'rails_helper'

RSpec.describe AccountsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "redirects to GET#show" do
      post :create, account: {subdomain: "AwesomeSD"}
      expect(subject).to redirect_to :action => :show
    end

    it "creates account" do
      post :create, account: {subdomain: "AwesomeSD"}
      expect(Account.find_by(subdomain: "AwesomeSD")).to_not be_nil
    end

    context "account with subdomain already exists" do
      before (:each) do
        Account.create(subdomain: "MySuperSD")
      end
      it "doesn't create new account" do
        post :create, account: {subdomain: "MySuperSD"}
        expect(Account.where(subdomain: "MySuperSD").count).to eq(1)
      end
      it "redirects to GET#new" do
        post :create, account: {subdomain: "MySuperSD"}
        expect(subject).to redirect_to :action => :new
      end
    end

    context "invalid subdomain sent" do
      ["MySuperSD!!!","1"].each do |subdomain|
        before (:each) do
          post :create, account: {subdomain: subdomain}
        end
        it "doesn't create new account" do
          expect(Account.find_by(subdomain: subdomain)).to be_nil
        end

        it "sets error message in flash" do
          expect(subject).to set_flash[:alert].to(/invalid subdomain/)
        end

        it "redirects to GET#new" do
          expect(subject).to redirect_to :action => :new
        end
      end
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
