require 'rails_helper'

RSpec.describe Account, type: :model do
  it "has subdomain attribute" do
    account = create :account
    expect(Account.find_by subdomain: "MySuperSD").to eq(account)
  end
  it { is_expected.to validate_uniqueness_of(:subdomain).case_insensitive.with_message('already taken') }
  it { is_expected.to allow_value('333abcz').for(:subdomain) }
  it { is_expected.to_not allow_value('123!', '!abc').for(:subdomain).with_message('invalid subdomain') }
  it { is_expected.to validate_length_of(:subdomain).is_at_least(2).is_at_most(20).with_message('invalid subdomain') }

  it {is_expected.to validate_presence_of :email}
  it {is_expected.to validate_presence_of :password}
  it {is_expected.to have_db_column(:user_logged_in).of_type(:boolean)}
end
