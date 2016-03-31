Given(/^User is on the home page/i) do
  visit '/'
end

When(/^User clicks on the (.+) button$/) do |buttonName|
  click_on(buttonName)
end

Then(/^User should see the evaluations page$/) do
  current_path.should == '/evaluation'
end

Then(/^User should see the faculty member historical data page$/) do
  current_path.should == '/instructor'
end

Then(/^User should see a (.+) button$/) do |buttonName|
  page.should have_selector(:link_or_button, buttonName)
end

Then(/^User should see (.+) as a title$/) do |title|
  page.should have_content(title)
end

