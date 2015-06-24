require 'rails_helper'

RSpec.describe Account, type: :model do
  it "has subdomain attribute" do
    variable = Account.create(subdomain: "MySuperSD")
    expect(Account.find_by subdomain: "MySuperSD").to eq(variable)
  end
  it { is_expected.to validate_uniqueness_of(:subdomain) }
end
