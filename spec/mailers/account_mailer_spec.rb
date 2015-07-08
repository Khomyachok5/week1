require "rails_helper"

RSpec.describe AccountMailer, type: :mailer do
  describe "reset_password" do
    let(:email_address) { "fffffffff@brain.com" }
    let(:mail) { AccountMailer.reset_password(email_address) }
    
    it "sets destination e-mail" do
      expect(mail.to).to eq([email_address])
    end

    it "sets an appropriate subject" do
      expect(mail.subject).to eq('Password re-set instructions for Week1')
    end
  end
end