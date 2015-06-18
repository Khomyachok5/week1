Transform(/^RegisterLink$/) do |impersonator|
  'Create new account'
end

Transform(/^create new account$/) do |impersonator|
  '/users/new/'
end

