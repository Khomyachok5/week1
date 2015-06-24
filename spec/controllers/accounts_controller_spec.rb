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
        accounts = Account.all
        post :create, account: {subdomain: "MySuperSD"}
        expect(Account.all).to eq(accounts)
      end
      it "redirects to GET#new" do
        post :create, account: {subdomain: "MySuperSD"}
        expect(subject).to redirect_to :action => :new
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
