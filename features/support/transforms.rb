Transform(/^"Create new account" page$/) do |impersonator|
  '/accounts/new'
end

Transform(/^"Start" page$/) do |impersonator|
  '/'
end

Transform(/^"Account admin panel" page$/) do |impersonator|
  '/admin'
end