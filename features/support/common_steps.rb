Given(/^User is authenticated$/)do
  email = 'testing@man.net'
  password = 'secretpass'
  User.new(:email => email, :password => password, :password_confirmation => password).save!

  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Log in"
end

Given(/^User is on the home page/i) do
  visit '/'
end

When(/^User clicks on the (.+) button$/) do |buttonName|
  click_on(buttonName)
end

When(/^User fills in ([A-Za-z0-9 ,.]+)$/) do |fill_ins|
  fill_ins.split(",").each do |fill_in|
    field_name, value = fill_in.strip.split(" with ")
    fill_in(field_name, :with => value)
  end
end

When(/^User selects (.+) from the (.+) select menu$/) do |value, select_name|
  select value, :from => select_name
end

Then(/^User should see input fields for ([A-Za-z0-9 ,]+)$/) do |fields|
  fields.split(",").each do |field|
    field = field.strip
    page.should have_field(field)
  end
end

Then(/^User should see a table of (\d+) data rows$/) do |n|
  expect(page).to have_css("tbody > tr", count: n.to_i)
end
