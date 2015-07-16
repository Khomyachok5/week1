Transform(/^"Create new account" page$/) do |impersonator|
  'localhost:8080/accounts/new'
end

Transform(/^"Start" page$/) do |impersonator|
  'localhost:8080/'
end

Transform(/^"Account admin panel" page$/) do |impersonator|
  'mysupersd.localhost:8080/admin'
end