Transform(/^RegisterLink$/) do |impersonator|
  'Create new account'
end

Transform(/^create new account$/) do |impersonator|
  '/accounts/new'
end

