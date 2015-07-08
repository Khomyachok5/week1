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
      expect(subject).to redirect_to action: :show
    end

    it "creates account" do
      post :create, account: {subdomain: "AwesomeSD", email: "mysuper@e.mail", password: "coffeewithmilk"}
      expect(Account.find_by(subdomain: "AwesomeSD")).to_not be_nil
    end

    it "logs account in" do
      post :create, account: {subdomain: "AwesomeSD", email: "mysuper@e.mail", password: "coffeewithmilk"}
      expect(session[:UserLoggedIn]).to be_truthy
    end

    context "account with subdomain already exists" do
      before (:each) do
        Account.create!(subdomain: "MySuperSD", email: 'blahblah@controller.ru', password: 'abcdefg')
      end
      it "doesn't create new account" do
        post :create, account: {subdomain: "MySuperSD", email: "mysuper@e.mail", password: "pwd1"}
        expect(Account.where(subdomain: "MySuperSD").count).to eq(1)
      end
      it "redirects to GET#new" do
        post :create, account: {subdomain: "MySuperSD"}
        expect(subject).to redirect_to action: :new
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
          expect(subject).to redirect_to action: :new
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
        expect(subject).to redirect_to action: :new
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
    let (:email) {'valid@controller.ru'}
    let (:posted_email) { email }
    before (:each) do
      Account.create!(subdomain: "MySuperSD", email: email, password: 'abcde')
      post :forgotpassword, login: { email: posted_email }
    end

    it "redirects to #reset" do
      expect(subject).to redirect_to action: :reset
    end

    it "sets an appropriate flash notice" do
      expect(subject).to set_flash[:notice].to('instructions were sent')
    end

    it "sets an appropriate session e-mail" do
      expect(subject).to set_session[:email].to(email)
    end

    ['valid@controller.ru', 'gorod@spb.ru'].each do |email_tested|
      context "with #{email_tested} address" do
        let (:email) {email_tested}
        it "sets an appropriate flash error" do
          expect(subject).to set_flash[:alert].to("Couldn't find account for #{email}")
        end
      end
    end

    it "sends an e-mail" do
      expect(ActionMailer::Base.deliveries.last.to).to eq([email])
    end

    context "with an invalid e-mail" do
      let (:posted_email) {'rrrr@dom.ru'}

      it "doesn't send an e-mail" do
        expect(ActionMailer::Base.deliveries.last).to be_nil
      end
    end
  end

  describe "POST #login" do
    context "with correct credentials" do
      before (:each) do
        Account.create!(subdomain: "MySuperSD", email: "megamail@mu.mu", password: "securePWD")
        post :login, login: {email: "megamail@mu.mu", password: "securePWD"}
      end

      it "redirects to #show" do
        expect(subject).to redirect_to action: :show
      end

      it "logs account in" do
        expect(session[:UserLoggedIn]).to be_truthy
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
