require 'rails_helper'

RSpec.describe AccountsController, type: :controller do

  context "account exists" do
    let(:account) { create(:account) }

    context 'with session email set' do
      before(:each) { session[:email] = account.email }

      describe "POST #update" do
        let(:pass) { account.password.reverse }
        before (:each) do
          post :update, account: { password: pass }
        end

        it "redirects to #edit" do
          expect(subject).to redirect_to action: :edit
        end

        it "updates password" do
          expect(Account.find_by(email: account.email).password).to eq(pass)
        end
      end
    end
  end

  context "user successfully logged in" do
    before (:each) do
      session[:UserLoggedIn] = true
    end

    describe "GET #edit" do
      before (:each) do
        get :edit
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "doesn't set flash to an error" do
        expect(flash[:alert]).to be_nil
      end
    end
  end


  context "user is not logged in" do
    describe "GET #edit" do
      before (:each) do
        get :edit
      end

      it "redirects to site#index" do
        expect(subject).to redirect_to controller: :site, action: :index
      end

      it "sets error message in flash" do
        expect(subject).to set_flash[:alert].to('Log in to manage your store')
      end
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "account does not exist" do
      let(:account) { build(:account) }
      before (:each) do
        post :create, account: {subdomain: account.subdomain, email: account.email, password: account.password}
      end

      it "redirects to GET#show" do
        expect(subject).to redirect_to action: :show
      end

      it "creates account" do
        expect(Account.find_by(subdomain: account.subdomain)).to_not be_nil
      end

      it "logs account in" do
        expect(session[:UserLoggedIn]).to be_truthy
      end
    end

    context "account with subdomain already exists" do
      let(:account){create(:account)}
      before (:each) do
        post :create, account: {subdomain: account.subdomain, email: "mysuper@e.mail", password: "pwd1"}
      end

      it "doesn't create new account" do
        expect(Account.where(subdomain: account.subdomain).count).to eq(1)
      end
      it "redirects to GET#new" do
         expect(subject).to redirect_to action: :new
      end
    end

    ["MySuperSD!!!","1"].each do |subdomain|
      context "invalid subdomain sent" do
        let (:account) { build(:account) }
        before (:each) do
          post :create, account: {subdomain: subdomain, email: account.email, password: account.password}
        end
        it "doesn't create new account" do
          expect(Account.find_by(subdomain: subdomain)).to be_nil
        end

        it "sets error message in flash" do
          expect(subject).to set_flash[:alert].to(/invalid subdomain/)
        end

        it "redirects to GET#new" do
          expect(subject).to redirect_to action: :new
        end
      end
    end

    [:email, :password].each do |param|
      context "blank #{param} sent" do
        let (:account) { build(:account) }
        before(:each) do
          post :create, account: { subdomain: account.subdomain,
            email: account.subdomain,
            password: account.password }.merge({ param => '' })
        end
        it "doesn't create new account" do
          expect(Account.find_by(subdomain: account.subdomain)).to be_nil
        end
        it "redirects to GET#new" do
          expect(subject).to redirect_to action: :new
        end
      end
    end
  end

  context "user successfully logged in" do
    before (:each) do
      session[:UserLoggedIn] = true
    end

    describe "GET #show" do
      before (:each) do
        get :show
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders show template" do
        expect(response).to render_template(:show)
      end

      it "doesn't set flash to error" do
        expect(flash[:alert]).to be_nil
      end
    end
  end

  context "User is not logged in"
    describe "GET #show" do
      before (:each) do
        get :show
      end

      it "redirects to site#index" do
        expect(subject).to redirect_to controller: :site, action: :index
      end

      it "sets an appropriate flash error" do
        expect(subject).to set_flash[:alert].to('Log in to manage your store')
      end
    end

  describe "GET #reset" do
    it "returns http success" do
      get :reset
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #forgotpassword" do
    let!(:account) {create :account}
    let (:email) {account.email}
    before (:each) do
      post :forgotpassword, login: { email: email }
    end

    it "redirects to #reset" do
      expect(subject).to redirect_to action: :reset
    end

    it "sets an appropriate flash notice" do
      expect(subject).to set_flash[:notice].to('instructions were sent')
    end

    it "sets an appropriate session e-mail" do
      expect(subject).to set_session[:email].to(account.email)
    end

    it "sends an e-mail" do
      expect(ActionMailer::Base.deliveries.last.to).to eq([account.email])
    end

    ['valid@controller.ru', 'gorod@spb.ru'].each do |email_tested|
      context "with #{email_tested} address" do
        let (:email) {email_tested}
        it "sets an appropriate flash error" do
          expect(subject).to set_flash[:alert].to("Couldn't find account for #{email}")
        end

        it "doesn't send an e-mail" do
          expect(ActionMailer::Base.deliveries.last).to be_nil
        end
      end
    end
  end

  describe "POST #login" do
    context "with correct credentials" do
      let(:email) {'megamail@mu.mu'}
      before (:each) do
        Account.create!(subdomain: "MySuperSD", email: email, password: "securePWD")
        post :login, login: {email: email, password: "securePWD"}
      end

      it "redirects to #show" do
        expect(subject).to redirect_to action: :show
      end

      it "logs account in" do
        expect(session[:UserLoggedIn]).to be_truthy
      end

      it "sets an appropriate session e-mail" do
        expect(subject).to set_session[:email].to(email)
      end
    end

    context "with wrong credentials" do
      before (:each) do
        post :login, login: {email: "megilqweqweqw1233@mu.mu", password: "!@#{}securePWD"}
      end

      it "redirects to site#index" do
        expect(subject).to redirect_to action: :index, controller: :site
      end
    end
  end

  context 'with an existing account' do
    before(:each) { Account.create!(subdomain: "MySuperSD", email: email, password: "securePWD") }

    context 'with session email set' do
      before(:each) { session[:email] = email }

      describe "POST #update_pass" do
        let (:pass) { "new_pass" }
        let (:email) { 'valid_account@nnn.ru' }
        before(:each) do
          post :update_pass, account: {password: pass}
        end

        it "redirects to site#index" do
          expect(subject).to redirect_to action: :index, controller: :site
        end

        it "sets an appropriate flash notice" do
          expect(subject).to set_flash[:notice].to('Password successfully changed')
        end

        it "updates password" do
          expect(Account.find_by(email: email).password).to eq(pass)
        end
      end
    end
  end
end
