Given(/^I am not logged in$/) do
  visit '/users/sign_out'
end

Given(/^I log in with the correct password$/) do
  click_link 'Log in'
  email = 'test@artist.net'
  password = 'password'
  @user = User.create!(email: email, password: password)
  @user.confirm

  visit '/users/sign_in'
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  click_button 'Log in'
end

Given(/^I am signed in$/) do
  step ('I log in with the correct password')
end
