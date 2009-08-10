class InviteSender < Application
  def send_invite(login)
     @user = User.first(login: login)

      send_mail(InviteMailer, :invite, {
        :from => "filthysock@gmail.com",
        :to =>   "filthysock@gmail.com",
        :subject => "#{@user.type.capitalize} Birthday!"
      }, { :user => @user })
      
      "invite resent!"
  end
end
