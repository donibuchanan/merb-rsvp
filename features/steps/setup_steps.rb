Given /^I am a user "(.*)" with password "(.*)"$/ do |login,password|
  @user = User.new(:login=>login)
  @user.password = @user.password_confirmation = password
  @user.save
end

Given /^I have an invite$/ do
  @user.invites.build if @user.invites.empty?
end
