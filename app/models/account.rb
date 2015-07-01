class Account < ActiveRecord::Base
  validates :subdomain, uniqueness: { message: 'already taken' }
  validates :subdomain, format: { with: /\A[0-9a-z]{2,20}\Z/i, message: 'invalid subdomain' }
  validates :email, :password, presence: true
end
