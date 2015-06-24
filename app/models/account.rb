class Account < ActiveRecord::Base
  validates :subdomain, uniqueness: true
end
