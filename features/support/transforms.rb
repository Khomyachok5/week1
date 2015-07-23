Transform(/^"Create new account" page$/) do |impersonator|
  'lvh.me:3000/accounts/new'
end

Transform(/^"Start" page$/) do |impersonator|
  'lvh.me:3000/'
end

Transform(/^"Account admin panel" page$/) do |impersonator|
  'mysupersd.lvh.me:3000/admin'
end