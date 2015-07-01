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
      post :create, account: {subdomain: "AwesomeSD", email: "mysuper@e.mail", password: "Iwantcoffee"}
      expect(subject).to redirect_to :action => :show
    end

    it "creates account" do
      post :create, account: {subdomain: "AwesomeSD", email: "mysuper@e.mail", password: "coffeewithmilk"}
      expect(Account.find_by(subdomain: "AwesomeSD")).to_not be_nil
    end

    context "account with subdomain already exists" do
      before (:each) do
        Account.create(subdomain: "MySuperSD")
      end
      it "doesn't create new account" do
        post :create, account: {subdomain: "MySuperSD", email: "mysuper@e.mail", password: "pwd1"}
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

    context "blank email sent" do
      before (:each) do
        post :create, account: {subdomain: "SD1", email: "", password: "mypwd123"}
      end
      it "doesn't create new account" do
        expect(Account.find_by(subdomain: "SD1")).to be_nil
      end
      it "redirects to GET#new" do
        expect(subject).to redirect_to :action => :new
      end
    end

    context "blank password sent" do
      before (:each) do
        post :create, account: {subdomain: "SD2", email: "qwer@t.y", password: ""}
      end
      it "doesn't create new account" do
        expect(Account.find_by(subdomain: "SD2")).to be_nil
      end
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #forgotpassword" do
    it "returns http success" do
      get :forgotpassword
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #login" do
    it "logins with right credentials" do
      Account.create(subdomain: "MySuperSD", email: "megamail@mu.mu", password: "securePWD")
      post :login, login: {email: "megamail@mu.mu", password: "securePWD"}
      expect(subject).to redirect_to :action => :show #, :controller => :accounts
    end

    it "doesn't logins with wrong credentials" do
      post :login, login: {email: "megilqweqweqw1233@mu.mu", password: "!@#{}securePWD"}
      expect(subject).to redirect_to :action => :index, :controller => :site
    end
  end
end
