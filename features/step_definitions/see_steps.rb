Then(/^I should see "([^"]*)"$/) do |arg|
  expect(page).to have_content(arg)
end

Then(/^I should see my list of galleries$/) do
  step 'I should see "Your Galleries"'
end
