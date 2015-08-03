require "rails_helper"

RSpec.describe AccountMailer, type: :mailer do
  describe "reset_password" do
    let(:mail) { AccountMailer.reset_password(account.email) }
    let(:account) { create :account }
    
    it "sets destination e-mail" do
      expect(mail.to).to eq([account.email])
    end

    it "sets an appropriate subject" do
      expect(mail.subject).to eq('Password re-set instructions for Week1')
    end

    it 'has a link to subdomain' do
      expect(mail.html_part.body.to_s).to have_link('', href: set_new_pass_url(subdomain: account.subdomain))
    end
  end
end