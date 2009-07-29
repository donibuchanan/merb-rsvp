Given /^I am a user "(.*)" with password "(.*)"$/ do |login,password|
  @user = User.new(:login=>login)
  @user.password = @user.password_confirmation = password
  @user.save
  @user.invites.create
end

Given /^I have an invite$/ do
  @user.invites.build if @user.invites.empty?
end

Given /^I am logged in as "(.*)" with password "(.*)"$/ do |login,password|
  Given "I am not authenticated"
  And "I am a user \"#{login}\" with password \"#{password}\""
  And "I have an invite"
  And "I go to /invites"
  And "I fill in \"login\" with \"#{login}\""
  And "I fill in \"password\" with \"#{password}\""
  And "I press \"Log In\""
end
