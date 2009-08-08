Given /^I am a user "(.*)" with password "(.*)"$/ do |login,password|
  @user = User.new(:login=>login)
  @user.password = @user.password_confirmation = password
  @user.save
end

Given /^I have invites for "(.*)"$/ do |invites|
  invites.split(",").each do |invite|
    @user.invites.create(name: invite)
  end
end

Given /^I am logged in as "(.*)" with password "(.*)" with invites? for "(.*)"$/ do |login,password,invites|
  Given "I am not authenticated"
  And "I am a user \"#{login}\" with password \"#{password}\""
  And "I have invites for \"#{invites}\""
  And "I go to /invites"
  And "I fill in \"login\" with \"#{login}\""
  And "I fill in \"password\" with \"#{password}\""
  And "I press \"Log In\""
end
